#!/usr/bin/env bash

PLATFORM=${TARGET_PLATFORM:-$1}
LINK=${GOOGLE_GET_BUCKET_HOST:-"https://storage.googleapis.com/storage/v1/b/${GOOGLE_BUCKET_NAME:-$2}/o"}
TOKEN=${GOOGLE_OAUTH_TOKEN:-$(cat "$3" || echo "$3")}
KEYSTORE_FOLDER=${KEYSTORE_FOLDER:-$4}

write_arguments_to_file() {
  mkdir -p "$(dirname "$2")"
  echo "$1" | tr -d '"' > "$2"
}

write_arguments_to_github_environment() {
  echo "BUILD_ARGUMENTS=$1" | tr -d '"' >> "$GITHUB_ENV"
}

get_build_arguments() {
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

  local FILE="$KEYSTORE_FOLDER/safe/$PLATFORM/build-arguments.txt"

  BUILD_ARGUMENTS=$(
    curl \
      -X GET \
      -H "Authorization: Bearer $TOKEN" \
      -H "Content-Type: text/plain" \
      "$LINK/build-arguments%2F$PLATFORM.txt?alt=media"
  )

  if [[ -z "${GITHUB_ENV}" ]]
    then
      write_arguments_to_file "$BUILD_ARGUMENTS" "$FILE"
    else
      write_arguments_to_github_environment "$BUILD_ARGUMENTS"
  fi
}

get_build_arguments
