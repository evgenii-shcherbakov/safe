#!/usr/bin/env bash

KEY="${GOOGLE_PRIVATE_KEY_PATH:-$1}"
PASSWORD="${GOOGLE_PRIVATE_KEY_PASSWORD:-$2}"
ACCOUNT="${GOOGLE_SERVICE_ACCOUNT:-$3}"

FRONTEND_FOLDER="$FRONTEND_FOLDER"

PRIVATE_KEY_PATH=""

convert_p12_to_pem() {
  PRIVATE_KEY_PATH="$(echo $1 | sed 's/\..*//').pem"
  openssl pkcs12 -in "$1" -nodes -nocerts -passin "pass:$2" > "$PRIVATE_KEY_PATH"
}

write_token_to_file() {
  local RAW_TOKEN
  local KEY_PATH

  RAW_TOKEN=$(echo "$1" | tr -d '"')
  KEY_PATH="$(dirname "$PRIVATE_KEY_PATH")/token.txt"

  echo "$RAW_TOKEN" > "$KEY_PATH"
  echo "GOOGLE_OAUTH_TOKEN=$RAW_TOKEN" >> "$FRONTEND_FOLDER/local.env"
}

write_token_to_github_environment() {
  echo "GOOGLE_OAUTH_TOKEN=$1" >> "$GITHUB_ENV"
  echo "GOOGLE_OAUTH_TOKEN=$1" | tr -d '"' >> .github/shared/.env
}

generate_token() {
  local JSON_HEADER
  local JSON_HEADER_ENCODED
  local IAT
  local JSON_CLAIM
  local JSON_CLAIM_ENCODED
  local HEAD_AND_CLAIM_TR
  local SIGNATURE_ENCODED
  local SIGNATURE_TR
  local RESPONSE
  local TOKEN

  convert_p12_to_pem "$KEY" "$PASSWORD"

  local ALG=RS256
  local TYP=JWT

  JSON_HEADER=$( jq -n --arg alg "$ALG" --arg typ "$TYP"  '{alg: $alg, typ: $typ}' )
  JSON_HEADER_ENCODED=$(echo -n $JSON_HEADER | openssl base64 -e)

  local ISS="$ACCOUNT"
  local SCOPE="https://www.googleapis.com/auth/cloud-platform"
  local AUD="https://oauth2.googleapis.com/token"

  IAT=$(date +%s)
  local EXP=$(($IAT + 3600))

  JSON_CLAIM=$(
    jq \
      -n \
      --arg iss "$ISS" \
      --arg scope "$SCOPE" \
      --arg aud "$AUD" \
      --arg exp "$EXP" \
      --arg iat "$IAT" \
      '{iss: $iss, scope: $scope, aud: $aud, exp: $exp, iat: $iat}'
  )

  JSON_CLAIM_ENCODED=$(echo -n $JSON_CLAIM | openssl base64 -e)
  HEAD_AND_CLAIM_TR=$(echo -n "$JSON_HEADER_ENCODED.$JSON_CLAIM_ENCODED" | tr -d '\n' | tr -d '=' | tr '/+' '_-')
  SIGNATURE_ENCODED=$(echo -n "$HEAD_AND_CLAIM_TR" | openssl dgst -sha256 -sign $PRIVATE_KEY_PATH | openssl base64 -e)
  SIGNATURE_TR=$(echo -n "$SIGNATURE_ENCODED" | tr -d '\n' | tr -d '=' | tr '/+' '_-')

  local JWT_ASSERTION="$HEAD_AND_CLAIM_TR.$SIGNATURE_TR"

  RESPONSE=$(
    curl \
      -H "Content-type: application/x-www-form-urlencoded" \
      -X POST "https://oauth2.googleapis.com/token" \
      -d "grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Ajwt-bearer&assertion=$JWT_ASSERTION"
  )

  TOKEN=$(echo $RESPONSE | jq ".access_token" | tr -d '"')

  if [[ -z "${GITHUB_ENV}" ]]
    then
      write_token_to_file "$TOKEN"
    else
      write_token_to_github_environment "$TOKEN"
  fi
}

generate_token
