#!/usr/bin/env bash

BUNDLE_NAME=${BUNDLE_NAME:-$1}
FRONTEND_FOLDER=${FRONTEND_FOLDER:-$2}
DIST_FOLDER=${DIST_FOLDER:-$3}
BUILD_ARGUMENTS=${BUILD_ARGUMENTS:-$4}

build() {
  echo Build APK and AAB files...

  cd "$FRONTEND_FOLDER" && flutter build apk $BUILD_ARGUMENTS
  cd "$FRONTEND_FOLDER" && flutter build appbundle $BUILD_ARGUMENTS
}

move_files() {
  echo Move output client files to build directory...

  mkdir -p "$DIST_FOLDER/android"

  cp -rp "$FRONTEND_FOLDER/build/app/outputs/flutter-apk/app-release.apk" "$DIST_FOLDER/android/$BUNDLE_NAME.apk"
  cp -rp "$FRONTEND_FOLDER/build/app/outputs/bundle/release/app-release.aab" "$DIST_FOLDER/android/$BUNDLE_NAME.aab"
}

build
move_files
