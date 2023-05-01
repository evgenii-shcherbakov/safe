#!/usr/bin/env bash

FRONTEND_FOLDER=${FRONTEND_FOLDER:-$1}
DIST_FOLDER=${DIST_FOLDER:-$2}
BUILD_ARGUMENTS=${BUILD_ARGUMENTS:-$3}

build() {
  echo Build web version...

  if [[ -z "${GITHUB_ENV}" ]]
    then
      cd "$FRONTEND_FOLDER" && flutter build web $BUILD_ARGUMENTS
    else
      cd "$FRONTEND_FOLDER" && flutter build web --release --base-href "/$BASE_HREF/" $BUILD_ARGUMENTS
    fi
}

move_files() {
  echo Move output web files to build directory...

  cp -rp "$FRONTEND_FOLDER/build/web" "$DIST_FOLDER"
}

build
move_files
