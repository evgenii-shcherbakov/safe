#!/usr/bin/env bash

APP_NAME="safe"
KEYSTORE_FOLDER="keystore"
DIST_FOLDER="dist"
FRONTEND_FOLDER="."
GOOGLE_PRIVATE_KEY_PASSWORD="$1"
GOOGLE_SERVICE_ACCOUNT="$2"
GOOGLE_BUCKET_NAME="$3"
GOOGLE_BUILD_NUMBER_FILE="$4"

PLATFORMS=("web" "android")

update_environment() {
  export $(<"$FRONTEND_FOLDER/local.env")
}

add_scripts_permissions() {
  chmod +x scripts/helpers/clean_dist_directory.sh
  chmod +x scripts/helpers/declare_env_variables.sh
  chmod +x scripts/google/generate_google_oauth_token.sh
  chmod +x scripts/google/get_build_arguments.sh
  chmod +x scripts/google/inc_build_number.sh

  chmod +x scripts/flutter/prebuild.sh
  chmod +x scripts/android/prebuild.sh

  for PLATFORM in "${PLATFORMS[@]}"
    do
      chmod +x "scripts/$PLATFORM/build.sh"
    done
}

prepare_environment() {
  export \
    APP_NAME="$APP_NAME" \
    DIST_FOLDER="$DIST_FOLDER" \
    KEYSTORE_FOLDER="$KEYSTORE_FOLDER" \
    FRONTEND_FOLDER="$FRONTEND_FOLDER" \
    GOOGLE_PRIVATE_KEY_PASSWORD="$GOOGLE_PRIVATE_KEY_PASSWORD" \
    GOOGLE_SERVICE_ACCOUNT="$GOOGLE_SERVICE_ACCOUNT" \
    GOOGLE_BUCKET_NAME="$GOOGLE_BUCKET_NAME" \
    GOOGLE_BUILD_NUMBER_FILE="$GOOGLE_BUILD_NUMBER_FILE" \
    BUNDLE_NAME="$APP_NAME-local" \
    BUILD_NUMBER="0"

  scripts/helpers/clean_dist_directory.sh
  scripts/helpers/declare_env_variables.sh

  update_environment

  scripts/google/generate_google_oauth_token.sh

  update_environment
}

build() {
  scripts/flutter/prebuild.sh
  scripts/android/prebuild.sh

  for PLATFORM in "${PLATFORMS[@]}"
    do
      scripts/google/get_build_arguments.sh "$PLATFORM" && "scripts/$PLATFORM/build.sh"
    done
}

add_scripts_permissions
prepare_environment
build
