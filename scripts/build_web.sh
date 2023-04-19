#!/bin/bash

rm -rf dist
mkdir dist

echo Install dependencies...

flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs

echo Test code...

flutter test

echo Build web version...

flutter build web --release --base-href "/$1/" \
--dart-define="FIREBASE_API_KEY=$FIREBASE_API_KEY" \
--dart-define="FIREBASE_APP_ID=$FIREBASE_APP_ID" \
--dart-define="FIREBASE_MESSAGING_SENDER_ID=$FIREBASE_MESSAGING_SENDER_ID" \
--dart-define="FIREBASE_AUTH_DOMAIN=$FIREBASE_AUTH_DOMAIN" \
--dart-define="FIREBASE_PROJECT_ID=$FIREBASE_PROJECT_ID" \
--dart-define="FIREBASE_STORAGE_BUCKET=$FIREBASE_STORAGE_BUCKET"

echo Move output web files to build directory...

cp -R build/web/* dist