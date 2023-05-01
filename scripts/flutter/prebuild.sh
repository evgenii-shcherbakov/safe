#!/usr/bin/env bash

FRONTEND_FOLDER=${FRONTEND_FOLDER:-$1}

install_dependencies() {
  echo Install dependencies...

  cd "$FRONTEND_FOLDER" && flutter pub get
  cd "$FRONTEND_FOLDER" && flutter packages pub run build_runner build --delete-conflicting-outputs
}

test_code() {
  echo Test code...

  cd "$FRONTEND_FOLDER" && flutter test
}

install_dependencies
test_code
