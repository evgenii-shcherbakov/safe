#!/usr/bin/env bash

FRONTEND_FOLDER=${FRONTEND_FOLDER:-$1}
ANDROID_RELEASE_SIGN_KEY_PATH=${ANDROID_RELEASE_SIGN_KEY_PATH:-$2}

move_sign_key() {
  local KEYSTORE_PATH="android/app/keystore"

  if [[ "$ANDROID_RELEASE_SIGN_KEY_PATH" != "" ]]
    then
      mkdir -p "$FRONTEND_FOLDER/$KEYSTORE_PATH" &&
      cp -rp "$ANDROID_RELEASE_SIGN_KEY_PATH" "$FRONTEND_FOLDER/$KEYSTORE_PATH/release.keystore"
  fi
}

move_sign_key
