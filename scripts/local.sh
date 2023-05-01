#!/usr/bin/env bash

GOOGLE_PRIVATE_KEY_PASSWORD="$1"
GOOGLE_SERVICE_ACCOUNT="$2"
GOOGLE_BUCKET_NAME="$3"
GOOGLE_BUILD_NUMBER_FILE="$4"

PLATFORMS=("web" "android")

load_configuration() {
  local CONFIG

  CONFIG=$(<fbs.json)

  export \
    DIST_FOLDER="$(echo "$CONFIG" | jq '.path.dist' | tr -d '"' || echo "dist" | tr -d '"')" \
    LOCAL_ENVIRONMENT_PATH="$(echo "$CONFIG" | jq '.local.environment' | tr -d '"' || echo "local.env" | tr -d '"')"
}

update_environment() {
  export $(<"$LOCAL_ENVIRONMENT_PATH")
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
    GOOGLE_PRIVATE_KEY_PASSWORD="$GOOGLE_PRIVATE_KEY_PASSWORD" \
    GOOGLE_SERVICE_ACCOUNT="$GOOGLE_SERVICE_ACCOUNT" \
    GOOGLE_BUCKET_NAME="$GOOGLE_BUCKET_NAME" \
    GOOGLE_BUILD_NUMBER_FILE="$GOOGLE_BUILD_NUMBER_FILE"

  load_configuration

  scripts/helpers/clean_dist_directory.sh
  scripts/helpers/declare_env_variables.sh

  update_environment

  export \
    BUNDLE_NAME="$APP_NAME-$LOCAL_BUNDLE_PREFIX" \
    BUILD_NUMBER="$LOCAL_BUILD_NUMBER"

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
