#!/usr/bin/env bash

VARIABLES_ARRAY=()

parse_config_file() {
  local CONFIG
  local APP_NAME
  local PATH_PARAMS
  local FRONTEND_FOLDER
  local DIST_FOLDER

  CONFIG=$(<fbs.json)
  APP_NAME=$(echo "$CONFIG" | jq '.appName' | tr -d '"' || echo "Exception: app name not provided" && exit 1)
  PATH_PARAMS=$(echo "$CONFIG" | jq '.path' || echo '{}')

  FRONTEND_FOLDER=$(echo "$PATH_PARAMS" | jq '.frontend' | tr -d '"' || echo "." | tr -d '"')
  DIST_FOLDER=$(echo "$PATH_PARAMS" | jq '.dist' | tr -d '"' || echo "dist" | tr -d '"')

  VARIABLES_ARRAY+=(
    "APP_NAME=$APP_NAME"
    "DIST_FOLDER=$DIST_FOLDER"
    "FRONTEND_FOLDER=$FRONTEND_FOLDER"
  )
}

declare_env_variables() {
  for VARIABLE in "${VARIABLES_ARRAY[@]}"
    do
      echo "$VARIABLE" >> "$GITHUB_ENV"
    done
}

main() {
  parse_config_file

  if [ "$GITHUB_ENV" != "" ]
    then
      declare_env_variables
  fi
}

main
