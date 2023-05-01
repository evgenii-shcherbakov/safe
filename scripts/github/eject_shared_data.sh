#!/usr/bin/env bash

APP_NAME=${APP_NAME:-$1}
FRONTEND_FOLDER=${FRONTEND_FOLDER:-$2}
DIST_FOLDER=${DIST_FOLDER:-$3}
KEYSTORE_FOLDER=${KEYSTORE_FOLDER:-$4}
PRIVATE_DATA_PASSWORD=${PRIVATE_DATA_PASSWORD:-$5}

eject_shared_data() {
  zip \
    -r \
    -e \
    "$DIST_FOLDER/shared-data.zip" \
    "$KEYSTORE_FOLDER/global" \
    "$KEYSTORE_FOLDER/$APP_NAME" \
    "$FRONTEND_FOLDER/lib" \
    "$FRONTEND_FOLDER/.dart_tool" \
    -P "$PRIVATE_DATA_PASSWORD"
}

eject_shared_data
