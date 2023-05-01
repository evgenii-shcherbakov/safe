#!/usr/bin/env bash

GOOGLE_PRIVATE_KEY_PASSWORD=${GOOGLE_PRIVATE_KEY_PASSWORD:-$1}
GOOGLE_SERVICE_ACCOUNT=${GOOGLE_SERVICE_ACCOUNT:-$2}
GOOGLE_BUCKET_NAME=${GOOGLE_BUCKET_NAME:-$3}
GOOGLE_BUILD_NUMBER_FILE=${GOOGLE_BUILD_NUMBER_FILE:-$4}

SHARED_ENVIRONMENT_PATH=""
LOCAL_ENVIRONMENT_PATH=""

VARIABLES_ARRAY=()

parse_config_file() {
  local CONFIG
  local APP_NAME
  local PATH_PARAMS
  local LOCAL_PARAMS
  local KEYSTORE_FOLDER
  local FRONTEND_FOLDER
  local DIST_FOLDER
  local LOCAL_BUNDLE_PREFIX
  local LOCAL_BUILD_NUMBER

  CONFIG=$(<fbs.json)

  APP_NAME=$(echo "$CONFIG" | jq '.appName' | tr -d '"' || echo "Exception: app name not provided" && exit 1)

  PATH_PARAMS=$(echo "$CONFIG" | jq '.path' || echo '{}')
  LOCAL_PARAMS=$(echo "$CONFIG" | jq '.local' || echo '{}')

  FRONTEND_FOLDER=$(echo "$PATH_PARAMS" | jq '.frontend' | tr -d '"' || echo "." | tr -d '"')
  KEYSTORE_FOLDER=$(echo "$PATH_PARAMS" | jq '.keystore' | tr -d '"' || echo "keystore" | tr -d '"')
  DIST_FOLDER=$(echo "$PATH_PARAMS" | jq '.dist' | tr -d '"' || echo "dist" | tr -d '"')

  LOCAL_ENVIRONMENT_PATH=$(echo "$LOCAL_PARAMS" | jq '.environment' | tr -d '"' || echo "local.env" | tr -d '"')
  LOCAL_BUNDLE_PREFIX=$(echo "$LOCAL_PARAMS" | jq '.bundlePrefix' | tr -d '"' || echo "local" | tr -d '"')
  LOCAL_BUILD_NUMBER=$(echo "$LOCAL_PARAMS" | jq '.buildNumber' | tr -d '"' || echo 0 | tr -d '"')

  SHARED_ENVIRONMENT_PATH="$KEYSTORE_FOLDER/$APP_NAME/.env"

  VARIABLES_ARRAY+=(
    "APP_NAME=$APP_NAME"
    "KEYSTORE_FOLDER=$KEYSTORE_FOLDER"
    "DIST_FOLDER=$DIST_FOLDER"
    "FRONTEND_FOLDER=$FRONTEND_FOLDER"
    "LOCAL_ENVIRONMENT_PATH=$LOCAL_ENVIRONMENT_PATH"
    "LOCAL_BUNDLE_PREFIX=$LOCAL_BUNDLE_PREFIX"
    "LOCAL_BUILD_NUMBER=$LOCAL_BUILD_NUMBER"
    "ANDROID_RELEASE_SIGN_KEY_PATH=$KEYSTORE_FOLDER/global/android/release-sign-key.keystore"
    "GOOGLE_P12_PRIVATE_KEY_PATH=$KEYSTORE_FOLDER/$APP_NAME/google/private-key.p12"
    "GOOGLE_PEM_PRIVATE_KEY_PATH=$KEYSTORE_FOLDER/$APP_NAME/google/private-key.pem"
    "GOOGLE_OAUTH_TOKEN_PATH=$KEYSTORE_FOLDER/$APP_NAME/google/token.txt"
    "SHARED_ENVIRONMENT_PATH=$SHARED_ENVIRONMENT_PATH"
  )

  local PLATFORMS=("web" "android" "ios" "macos" "linux" "windows")

  for PLATFORM in "${PLATFORMS[@]}"
    do
      UPPERCASE_PLATFORM="$(echo "$PLATFORM" | tr '[:lower:]' '[:upper:]')"

      VARIABLES_ARRAY+=(
        "${UPPERCASE_PLATFORM}_BUILD_ARGUMENTS_PATH=$KEYSTORE_FOLDER/$APP_NAME/$PLATFORM/build-arguments.txt"
      )
    done
}

inject_external_variables() {
  VARIABLES_ARRAY+=(
    "BASE_HREF=$BASE_HREF"
    "GOOGLE_PRIVATE_KEY_PASSWORD=$GOOGLE_PRIVATE_KEY_PASSWORD"
    "GOOGLE_SERVICE_ACCOUNT=$GOOGLE_SERVICE_ACCOUNT"
    "GOOGLE_BUCKET_NAME=$GOOGLE_BUCKET_NAME"
    "GOOGLE_BUILD_NUMBER_FILE=$GOOGLE_BUILD_NUMBER_FILE"
    "GOOGLE_GET_BUCKET_HOST=https://storage.googleapis.com/storage/v1/b/$GOOGLE_BUCKET_NAME/o"
    "GOOGLE_UPLOAD_BUCKET_HOST=https://storage.googleapis.com/upload/storage/v1/b/$GOOGLE_BUCKET_NAME/o"
  )
}

declare_env_variables() {
  rm -rf "$SHARED_ENVIRONMENT_PATH"
  rm -rf "$LOCAL_ENVIRONMENT_PATH"

  mkdir -p "$(dirname "$SHARED_ENVIRONMENT_PATH")"

  for VARIABLE in "${VARIABLES_ARRAY[@]}"
    do
      if [ -z "$GITHUB_ENV" ]
        then
          echo "$VARIABLE" | tr -d '"' >> "$LOCAL_ENVIRONMENT_PATH"
        else
          echo "$VARIABLE" >> "$GITHUB_ENV"
          echo "$VARIABLE" | tr -d '"' >> "$SHARED_ENVIRONMENT_PATH"
      fi
    done
}

parse_config_file
inject_external_variables
declare_env_variables
