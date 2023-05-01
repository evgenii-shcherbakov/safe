#!/usr/bin/env bash

FRONTEND_FOLDER=${FRONTEND_FOLDER:-$1}
DIST_FOLDER=${DIST_FOLDER:-$2}
KEYSTORE_FOLDER=${KEYSTORE_FOLDER:-$3}
PRIVATE_DATA_PASSWORD=${PRIVATE_DATA_PASSWORD:-$4}

eject_shared_data() {
  zip \
    -r \
    -e \
    "$DIST_FOLDER/shared-data.zip" \
    .github/shared/.env \
    "$KEYSTORE_FOLDER" \
    "$FRONTEND_FOLDER/lib/di" \
    "$FRONTEND_FOLDER/.dart_tool" \
    -P "$PRIVATE_DATA_PASSWORD"
}

eject_shared_data
