#!/usr/bin/env bash

FRONTEND_FOLDER=${FRONTEND_FOLDER:-$1}
KEYSTORE_FOLDER=${KEYSTORE_FOLDER:-$2}
PRIVATE_DATA_PASSWORD=${PRIVATE_DATA_PASSWORD:-$3}

clean_target_destinations() {
  rm -rf .github/shared/.env
  rm -rf "$KEYSTORE_FOLDER"
  rm -rf "${FRONTEND_FOLDER:?}/lib/di"
  rm -rf "${FRONTEND_FOLDER:?}/.dart_tool"

  mkdir -p .github/shared 
}

unzip_shared_data() {
  clean_target_destinations
  unzip -P "$PRIVATE_DATA_PASSWORD" shared-data.zip
}

read_env_file() {
  local ENV_VARIABLES

  ENV_VARIABLES=$(<.github/shared/.env)

  for VARIABLE in "${ENV_VARIABLES[@]}"
    do
      echo "$VARIABLE" >> "$GITHUB_ENV"
    done
}

unzip_shared_data
read_env_file
