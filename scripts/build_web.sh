#!/bin/bash

rm -rf dist
mkdir dist

echo Install dependencies...

flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs

echo Test code...

flutter test

echo Build web version...

# shellcheck disable=SC2086
flutter build web --release --base-href "/$1/" $BUILD_ARGUMENTS

echo Move output web files to build directory...

cp -R build/web/* dist