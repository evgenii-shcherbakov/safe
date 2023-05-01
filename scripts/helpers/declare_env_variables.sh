#!/usr/bin/env bash

APP_NAME=${APP_NAME:-$1}
KEYSTORE_FOLDER=${KEYSTORE_FOLDER:-$2}
DIST_FOLDER=${DIST_FOLDER:-$3}
FRONTEND_FOLDER=${FRONTEND_FOLDER:-$4}
GOOGLE_PRIVATE_KEY_PASSWORD=${GOOGLE_PRIVATE_KEY_PASSWORD:-$5}
GOOGLE_SERVICE_ACCOUNT=${GOOGLE_SERVICE_ACCOUNT:-$6}
GOOGLE_BUCKET_NAME=${GOOGLE_BUCKET_NAME:-$7}
GOOGLE_BUILD_NUMBER_FILE=${GOOGLE_BUILD_NUMBER_FILE:-$8}

BASE_HREF="$BASE_HREF"

write_variables_to_github_environment() {
  local PARAMS=("$@")

  [ -e ".github/shared/.env" ] || mkdir -p .github/shared

  for PARAM in "${PARAMS[@]}"
    do
      echo "$PARAM" >> "$GITHUB_ENV"
      echo "$PARAM" | tr -d '"' >> .github/shared/.env
    done
}

write_variables_to_local_environment() {
  local PARAMS=("$@")

  rm -rf "$FRONTEND_FOLDER/local.env"

  for PARAM in "${PARAMS[@]}"
    do
      echo "$PARAM" | tr -d '"' >> "$FRONTEND_FOLDER/local.env"
    done
}

declare_env_variables() {
  local PARAMS_ARRAY=(
    "APP_NAME=$APP_NAME"
    "KEYSTORE_FOLDER=$KEYSTORE_FOLDER"
    "DIST_FOLDER=$DIST_FOLDER"
    "FRONTEND_FOLDER=$FRONTEND_FOLDER"
    "BASE_HREF=$BASE_HREF"
    "GOOGLE_PRIVATE_KEY_PASSWORD=$GOOGLE_PRIVATE_KEY_PASSWORD"
    "GOOGLE_SERVICE_ACCOUNT=$GOOGLE_SERVICE_ACCOUNT"
    "GOOGLE_BUCKET_NAME=$GOOGLE_BUCKET_NAME"
    "GOOGLE_BUILD_NUMBER_FILE=$GOOGLE_BUILD_NUMBER_FILE"
    "ANDROID_RELEASE_SIGN_KEY_PATH=$KEYSTORE_FOLDER/global/android/release-sign-key.keystore"
    "GOOGLE_P12_PRIVATE_KEY_PATH=$KEYSTORE_FOLDER/$APP_NAME/google/private-key.p12"
    "GOOGLE_PEM_PRIVATE_KEY_PATH=$KEYSTORE_FOLDER/$APP_NAME/google/private-key.pem"
    "GOOGLE_GET_BUCKET_HOST=https://storage.googleapis.com/storage/v1/b/$GOOGLE_BUCKET_NAME/o"
    "GOOGLE_UPLOAD_BUCKET_HOST=https://storage.googleapis.com/upload/storage/v1/b/$GOOGLE_BUCKET_NAME/o"
    "GOOGLE_OAUTH_TOKEN_PATH=$KEYSTORE_FOLDER/$APP_NAME/google/token.txt"
  )

  local PLATFORMS=("web" "android" "ios" "macos" "linux" "windows")

  for PLATFORM in "${PLATFORMS[@]}"
    do
      UPPERCASE_PLATFORM="$(echo "$PLATFORM" | tr '[:lower:]' '[:upper:]')"

      PARAMS_ARRAY+=(
        "${UPPERCASE_PLATFORM}_BUILD_ARGUMENTS_PATH=$KEYSTORE_FOLDER/$APP_NAME/$PLATFORM/build-arguments.txt"
      )
    done

  if [ -z "$GITHUB_ENV" ]
    then
      write_variables_to_local_environment "${PARAMS_ARRAY[@]}"
    else
      write_variables_to_github_environment "${PARAMS_ARRAY[@]}"
  fi
}

declare_env_variables
