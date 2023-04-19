#!/bin/bash

rm -rf dist
mkdir dist

echo Install dependencies...

flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs

echo Test code...

flutter test

echo Build APK and AAB files...

# shellcheck disable=SC2046
flutter build apk $(curl "$BUILD_ARGUMENTS_LINK")
# shellcheck disable=SC2046
flutter build appbundle $(curl "$BUILD_ARGUMENTS_LINK")

echo Move output client files to build directory...

mv "build/app/outputs/flutter-apk/app-release.apk" "dist/$1.apk"
mv "build/app/outputs/bundle/release/app-release.aab" "dist/$1.aab"