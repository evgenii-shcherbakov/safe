#!/usr/bin/env bash

APP_NAME=${APP_NAME:-$1}
FRONTEND_FOLDER=${FRONTEND_FOLDER:-$2}
KEYSTORE_FOLDER=${KEYSTORE_FOLDER:-$3}
PRIVATE_DATA_PASSWORD=${PRIVATE_DATA_PASSWORD:-$4}

clean_target_destinations() {
  rm -rf "$KEYSTORE_FOLDER"
  rm -rf "${FRONTEND_FOLDER:?}/lib"
  rm -rf "${FRONTEND_FOLDER:?}/.dart_tool"
}

unzip_shared_data() {
  unzip -P "$PRIVATE_DATA_PASSWORD" shared-data.zip
}

read_env_file() {
  local ENV_VARIABLES

  ENV_VARIABLES=$(<"$KEYSTORE_FOLDER/$APP_NAME/.env")

  for VARIABLE in "${ENV_VARIABLES[@]}"
    do
      echo "$VARIABLE" >> "$GITHUB_ENV"
    done
}

clean_target_destinations
unzip_shared_data
read_env_file
