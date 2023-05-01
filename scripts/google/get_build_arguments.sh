#!/usr/bin/env bash

PLATFORM=${TARGET_PLATFORM:-$1}
APP_NAME=${APP_NAME:-$2}
KEYSTORE_FOLDER=${KEYSTORE_FOLDER:-$3}
LINK=${GOOGLE_GET_BUCKET_HOST:-"https://storage.googleapis.com/storage/v1/b/${GOOGLE_BUCKET_NAME:-$4}/o"}
TOKEN=${GOOGLE_OAUTH_TOKEN:-$(cat "$GOOGLE_OAUTH_TOKEN_PATH" || cat "$5" || echo "$5")}

write_arguments_to_file() {
  mkdir -p "$(dirname "$2")"
  echo "$1" | tr -d '"' > "$2"
}

handle_arguments() {
  if [[ "$PLATFORM" == "" ]]
    then
      echo "Exception: platform not provided"
      exit 1
  fi

  if [[ "$LINK" == "" ]]
    then
      echo "Exception: bucket name or get bucket host are not provided"
      exit 1
  fi
}

get_build_arguments() {
  local BUILD_ARGUMENTS
  local VARIABLE_NAME

  BUILD_ARGUMENTS=$(
    curl \
      -X GET \
      -H "Authorization: Bearer $TOKEN" \
      -H "Content-Type: text/plain" \
      "$LINK/build-arguments%2F$PLATFORM.txt?alt=media"
  )

  VARIABLE_NAME="$(echo "$PLATFORM" | tr '[:lower:]' '[:upper:]')_BUILD_ARGUMENTS_PATH"

  write_arguments_to_file "$BUILD_ARGUMENTS" "${!VARIABLE_NAME}"
}

get_build_arguments
