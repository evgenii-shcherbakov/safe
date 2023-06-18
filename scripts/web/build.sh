#!/usr/bin/env bash

KEYSTORE_HOST=${KEYSTORE_HOST:-$1}
KEYSTORE_ACCESS_TOKEN=${KEYSTORE_ACCESS_TOKEN:-$2}
BASE_HREF=${BASE_HREF:-$3}
FRONTEND_FOLDER=${FRONTEND_FOLDER:-$4}
DIST_FOLDER=${DIST_FOLDER:-$5}

chmod +x scripts/flutter/prebuild.sh

build() {
  local BUILD_ARGUMENTS

  echo "Load build arguments..."
  BUILD_ARGUMENTS=$(
    curl \
      -X "POST" \
      -H "Authorization: Bearer $KEYSTORE_ACCESS_TOKEN" \
      -d "{\"platform\":\"web\",\"parser\":\"dart\"}" \
      --url "$KEYSTORE_HOST/applications/safe/build-arguments"
  )

  echo "Build web version..."
  cd "$FRONTEND_FOLDER" && flutter build web --release --base-href "/$BASE_HREF/" $BUILD_ARGUMENTS || exit 1
}

pack() {
  echo "Move output files to dist directory..."
  cp -rp "$FRONTEND_FOLDER/build/web" "$DIST_FOLDER/web" || exit 1
}

main() {
  scripts/flutter/prebuild.sh "$FRONTEND_FOLDER" "$DIST_FOLDER"
  build
  pack
}

main
