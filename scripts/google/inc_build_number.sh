#!/usr/bin/env bash

GOOGLE_OAUTH_TOKEN=${GOOGLE_OAUTH_TOKEN:-$(cat "$GOOGLE_OAUTH_TOKEN_PATH" || cat "$1" || echo "$1")}
GOOGLE_GET_BUCKET_HOST=${GOOGLE_GET_BUCKET_HOST:-"https://storage.googleapis.com/storage/v1/b/${GOOGLE_BUCKET_NAME:-$2}/o"}
GOOGLE_UPLOAD_BUCKET_HOST=${GOOGLE_UPLOAD_BUCKET_HOST:-"https://storage.googleapis.com/upload/storage/v1/b/${GOOGLE_BUCKET_NAME:-$2}/o"}
GOOGLE_BUILD_NUMBER_FILE=${GOOGLE_BUILD_NUMBER_FILE:-$3}

get_build_number() {
  curl \
    -X GET \
    -H "Authorization: Bearer $GOOGLE_OAUTH_TOKEN" \
    -H "Content-Type: text/plain" \
    "$GOOGLE_GET_BUCKET_HOST/$GOOGLE_BUILD_NUMBER_FILE?alt=media"
}

update_build_number() {
  curl \
    -X POST \
    -d "$1" \
    -H "Authorization: Bearer $GOOGLE_OAUTH_TOKEN" \
    -H "Content-Type: text/plain" \
    "$GOOGLE_UPLOAD_BUCKET_HOST?uploadType=media&name=$GOOGLE_BUILD_NUMBER_FILE"
}

write_build_number_to_local_environment() {
  echo "BUILD_NUMBER=$1" | tr -d '"' >> "$FRONTEND_FOLDER/local.env"
}

write_build_number_to_github_environment() {
  echo "BUILD_NUMBER=$1" >> "$GITHUB_ENV"
  echo "BUILD_NUMBER=$1" | tr -d '"' >> .github/shared/.env
}

inc_build_number() {
  local BUILD_NUMBER

  BUILD_NUMBER=$(get_build_number)
  ((BUILD_NUMBER = BUILD_NUMBER + 1))

  update_build_number "$BUILD_NUMBER"

  if [ -z "$GITHUB_ENV" ]
    then
      write_build_number_to_local_environment "$BUILD_NUMBER"
    else
      write_build_number_to_github_environment "$BUILD_NUMBER"
  fi
}

inc_build_number
