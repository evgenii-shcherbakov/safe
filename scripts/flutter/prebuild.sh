#!/usr/bin/env bash

FRONTEND_FOLDER=${FRONTEND_FOLDER:-$1}
DIST_FOLDER=${DIST_FOLDER:-$2}

chmod +x scripts/helpers/clean_dist_directory.sh

install_dependencies() {
  echo "Install dependencies..."
  cd "$FRONTEND_FOLDER" && flutter pub get || exit 1
  cd "$FRONTEND_FOLDER" && flutter packages pub run build_runner build --delete-conflicting-outputs || exit 1
}

main() {
  scripts/helpers/clean_dist_directory.sh "$DIST_FOLDER"
  install_dependencies
}

main
