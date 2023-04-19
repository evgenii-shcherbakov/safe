#!/bin/bash

rm -rf dist
mkdir dist

echo Install dependencies...

flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs

echo Test code...

flutter test

echo Build APK and AAB files...

flutter build apk \
--dart-define="FIREBASE_API_KEY=$FIREBASE_API_KEY" \
--dart-define="FIREBASE_APP_ID=$FIREBASE_APP_ID" \
--dart-define="FIREBASE_MESSAGING_SENDER_ID=$FIREBASE_MESSAGING_SENDER_ID" \
--dart-define="FIREBASE_PROJECT_ID=$FIREBASE_PROJECT_ID" \
--dart-define="FIREBASE_STORAGE_BUCKET=$FIREBASE_STORAGE_BUCKET"

flutter build appbundle \
--dart-define="FIREBASE_API_KEY=$FIREBASE_API_KEY" \
--dart-define="FIREBASE_APP_ID=$FIREBASE_APP_ID" \
--dart-define="FIREBASE_MESSAGING_SENDER_ID=$FIREBASE_MESSAGING_SENDER_ID" \
--dart-define="FIREBASE_PROJECT_ID=$FIREBASE_PROJECT_ID" \
--dart-define="FIREBASE_STORAGE_BUCKET=$FIREBASE_STORAGE_BUCKET"

echo Move output client files to build directory...

mv "build/app/outputs/flutter-apk/app-release.apk" "dist/$1.apk"
mv "build/app/outputs/bundle/release/app-release.aab" "dist/$1.aab"