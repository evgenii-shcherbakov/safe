#!/usr/bin/env bash

KEYSTORE_HOST=${KEYSTORE_HOST:-$1}
KEYSTORE_ACCESS_TOKEN=${KEYSTORE_ACCESS_TOKEN:-$2}
APP_NAME=${APP_NAME:-$3}
FRONTEND_FOLDER=${FRONTEND_FOLDER:-$4}
DIST_FOLDER=${DIST_FOLDER:-$5}

chmod +x scripts/flutter/prebuild.sh

test_code() {
  echo "Test code..."
  cd "$FRONTEND_FOLDER" && flutter test || exit 1
}

setup_git() {
  echo "Setup git..."
  git config user.name "GitHub Action"
  git config user.email "action@github.com"
  git config pull.rebase true
}

update_branch() {
  echo "Update git branch..."
  git add .
  git commit -m "Update version"
  git push
}

patch_version() {
  local FILE="$1"
  local PARTS
  local PATCH
  local NEW_VALUE
  local BUILD_NUMBER

  setup_git
  git stash

  echo "Increment build number..."
  BUILD_NUMBER=$(
    curl \
      -X "PATCH" \
      -H "Authorization: Bearer $KEYSTORE_ACCESS_TOKEN" \
      --url "$KEYSTORE_HOST/applications/$APP_NAME/build-number"
  )

  echo "Update application version..."
  flutter pub global activate pub_version_plus || exit 1
  cd "$FRONTEND_FOLDER" && pubversion patch || exit 1
  IFS='.' read -ra PARTS <<< $(awk '/version:/ {print $2}' "$FILE")
  PATCH=${PARTS[2]}
  PATCH=$((PATCH+1))
  NEW_VALUE="${PARTS[0]}.${PARTS[1]}.${PATCH}+${BUILD_NUMBER}"
  echo "${PARTS[0]}.${PARTS[1]}.${PATCH}" > "$DIST_FOLDER/version.txt"
  printf "%s\n" "H" "/version: /s/.*=\\([^=]*\\).*/\\1/p.*" "s//version: $NEW_VALUE/" "wq" | ed -s "$FILE" || exit 1

  update_branch
  git stash pop
}

versioning() {
  local SEARCH_PATTERN="version: "
  local FILE="$FRONTEND_FOLDER/pubspec.yaml"
  local PARTS

  echo "Update version..."

  if git diff HEAD~ HEAD --unified=0 -- "$FILE" | grep -q "+.*$SEARCH_PATTERN.*"
    then
      echo "Parameter 'version' in $FILE already updated, skip auto-patching..."
      IFS='+' read -ra PARTS <<< $(awk '/version:/ {print $2}' "$FILE")
      echo "${PARTS[0]}" > "$DIST_FOLDER/version.txt"
    else
      patch_version "$FILE"
  fi
}

main() {
  scripts/flutter/prebuild.sh "$FRONTEND_FOLDER" "$DIST_FOLDER"
  test_code
  versioning
}

main
