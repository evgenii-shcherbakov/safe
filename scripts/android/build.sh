#!/usr/bin/env bash

KEYSTORE_HOST=${KEYSTORE_HOST:-$1}
KEYSTORE_ACCESS_TOKEN=${KEYSTORE_ACCESS_TOKEN:-$2}
FRONTEND_FOLDER=${FRONTEND_FOLDER:-$3}
DIST_FOLDER=${DIST_FOLDER:-$4}
BUNDLE_NAME=${BUNDLE_NAME:-$5}

chmod +x scripts/flutter/prebuild.sh

build() {
  local KEYSTORE_PATH="$FRONTEND_FOLDER/android/app/keystore"
  local BUILD_ARGUMENTS
  local SIGN_DATA
  local SIGN_KEY_PASSWORD
  local SIGN_KEY_ALIAS
  local SIGN_KEY_ALIAS_PASSWORD

  echo "Load sign data..."
  SIGN_DATA=$(
    curl \
      -X POST \
      -H "Authorization: Bearer $KEYSTORE_ACCESS_TOKEN" \
      -d "{\"type\":\"release\"}" \
      --url "$KEYSTORE_HOST/applications/$APP_NAME/sign-keystore"
  )

  SIGN_KEY_PASSWORD=$(echo "$SIGN_DATA" | jq -r '.secrets.PASSWORD' | tr -d '"')
  SIGN_KEY_ALIAS=$(echo "$SIGN_DATA" | jq -r '.secrets.ALIAS' | tr -d '"')
  SIGN_KEY_ALIAS_PASSWORD=$(echo "$SIGN_DATA" | jq -r '.secrets.ALIAS_PASSWORD' | tr -d '"')

  echo "Place sign .keystore file..."
  mkdir -p "$KEYSTORE_PATH"
  echo "$SIGN_DATA" | jq -r '.secrets.FILE' | tr -d '"' > "$KEYSTORE_PATH/release.keystore"

  echo "Load build arguments..."
  BUILD_ARGUMENTS=$(
    curl \
      -X "POST" \
      -H "Authorization: Bearer $KEYSTORE_ACCESS_TOKEN" \
      -d "{\"platform\":\"android\",\"parser\":\"dart\"}" \
      --url "$KEYSTORE_HOST/applications/safe/build-arguments"
  )

  echo "Build APK and AAB files..."

  ANDROID_RELEASE_SIGN_KEY_KEYSTORE_PASSWORD="$SIGN_KEY_PASSWORD" \
  ANDROID_RELEASE_SIGN_KEY_ALIAS="$SIGN_KEY_ALIAS" \
  ANDROID_RELEASE_SIGN_KEY_PASSWORD="$SIGN_KEY_ALIAS_PASSWORD" \
    cd "$FRONTEND_FOLDER" && flutter build apk $BUILD_ARGUMENTS || exit 1

  ANDROID_RELEASE_SIGN_KEY_KEYSTORE_PASSWORD="$SIGN_KEY_PASSWORD" \
  ANDROID_RELEASE_SIGN_KEY_ALIAS="$SIGN_KEY_ALIAS" \
  ANDROID_RELEASE_SIGN_KEY_PASSWORD="$SIGN_KEY_ALIAS_PASSWORD" \
    cd "$FRONTEND_FOLDER" && flutter build appbundle $BUILD_ARGUMENTS || exit 1
}

pack() {
  local BUILD_NUMBER
  local BUNDLE_NAME
  local VERSION_NAME

  echo "Load actual build number..."
  BUILD_NUMBER=$(
    curl \
      -X GET \
      -H "Authorization: Bearer $KEYSTORE_ACCESS_TOKEN" \
      --url "$KEYSTORE_HOST/applications/$APP_NAME/build-number"
  )

  VERSION_NAME=$(awk '/version:/ {print $2}' "$FRONTEND_FOLDER/pubspec.yaml")
  BUNDLE_NAME="${APP_NAME}-${VERSION_NAME}"

  echo "Move output files to dist directory..."
  mkdir -p dist/android
  cp \
    -rp \
    "$FRONTEND_FOLDER/build/app/outputs/flutter-apk/app-release.apk" \
    "$DIST_FOLDER/android/$BUNDLE_NAME.apk" || exit 1
  cp \
    -rp \
    "$FRONTEND_FOLDER/build/app/outputs/bundle/release/app-release.aab" \
    "$DIST_FOLDER/android/$BUNDLE_NAME.aab" || exit 1
}

main() {
  scripts/flutter/prebuild.sh "$FRONTEND_FOLDER" "$DIST_FOLDER"
  build
  pack
}

main
