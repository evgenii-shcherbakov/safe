#!/bin/bash

rm -rf dist
mkdir dist

echo Install dependencies...

flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs

echo Test code...

flutter test

echo Build APK and AAB files...

flutter build apk --dart-define=BACKEND_URL="$BACKEND_URL"
flutter build appbundle --dart-define=BACKEND_URL="$BACKEND_URL"

echo Move output client files to build directory...

mv "build/app/outputs/flutter-apk/app-release.apk" "dist/$1.apk"
mv "build/app/outputs/bundle/release/app-release.aab" "dist/$1.aab"