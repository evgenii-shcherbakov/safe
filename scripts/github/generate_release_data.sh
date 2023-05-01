#!/usr/bin/env bash

APP_NAME=${APP_NAME:-$1}
GIT_TAG_NAME=${GIT_TAG_NAME:-$2}
BUILD_NUMBER=${BUILD_NUMBER:-$3}

FRONTEND_FOLDER="$FRONTEND_FOLDER"

generate_bundle_name() {
  echo "$APP_NAME-${GIT_TAG_NAME:-${BUILD_NUMBER:-"unknown"}}"
}

generate_release_tag() {
  [ -z "$GIT_TAG_NAME" ] && echo "#$BUILD_NUMBER" || echo "$GIT_TAG_NAME"
}

write_bundle_name_to_github_environment() {
  local BUNDLE_NAME

  BUNDLE_NAME=$(generate_bundle_name)

  echo "BUNDLE_NAME=$BUNDLE_NAME" >> "$GITHUB_ENV"
  echo "BUNDLE_NAME=$BUNDLE_NAME" | tr -d '"' >> .github/shared/.env
}

write_release_tag_to_github_environment() {
  local RELEASE_TAG

  RELEASE_TAG=$(generate_release_tag)

  echo "RELEASE_TAG=$RELEASE_TAG" >> "$GITHUB_ENV"
  echo "RELEASE_TAG=$RELEASE_TAG" | tr -d '"' >> .github/shared/.env
}

write_bundle_name_to_github_environment
write_release_tag_to_github_environment
