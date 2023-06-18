_safe_

# Flutter app

Cross-platform app for store credentials

### Tech stack

- Dart
- Flutter
- Provider
- Injectable
- Firebase

### Repository secrets

> Keystore injection
>
> - `KEYSTORE_GIT_REPOSITORY` name of git repository with keystore
> - `KEYSTORE_ACCESS_TOKEN` token for get access to keystore repository

> Android signing
> 
> - `ANDROID_RELEASE_SIGN_KEY_KEYSTORE_PASSWORD` used password for sign android app keystore file
> - `ANDROID_RELEASE_SIGN_KEY_ALIAS` used alias for sign android app using keystore
> - `ANDROID_RELEASE_SIGN_KEY_PASSWORD` used password for sign android app using keystore

> Google cloud integration
> 
> - `GOOGLE_BUCKET_NAME` name of used bucket in Google Cloud
> - `GOOGLE_PRIVATE_KEY_PASSWORD` password for .p12 Google Cloud certificate file from keystore
> - `GOOGLE_SERVICE_ACCOUNT` name of used Google service account
> - `GOOGLE_BUILD_NUMBER_FILE` name of file in bucket where build number is stored

> GitHub actions
> 
> - `PRIVATE_DATA_PASSWORD` password for private workflow artifacts

### Environment variables (inside the app)

> Android
> - `FIREBASE_API_KEY`
> - `FIREBASE_APP_ID`
> - `FIREBASE_MESSAGING_SENDER_ID`
> - `FIREBASE_PROJECT_ID`
> - `FIREBASE_STORAGE_BUCKET`

> Web
> - `FIREBASE_API_KEY`
> - `FIREBASE_APP_ID`
> - `FIREBASE_MESSAGING_SENDER_ID`
> - `FIREBASE_AUTH_DOMAIN`
> - `FIREBASE_PROJECT_ID`
> - `FIREBASE_STORAGE_BUCKET`

> IOS & MacOS
> - `FIREBASE_API_KEY`
> - `FIREBASE_APP_ID`
> - `FIREBASE_MESSAGING_SENDER_ID`
> - `FIREBASE_PROJECT_ID`
> - `FIREBASE_STORAGE_BUCKET`
> - `FIREBASE_IOS_CLIENT_ID`
> - `FIREBASE_IOS_BUNDLE_ID`

### Required file structure for keystore folder

- global
  - android
    - release-sign-key.keystore `keystore file for sign android apps`
- safe
  - google
    - private-key.p12 `.p12 Google Cloud certificate file`

### Load project

```shell
git clone git@github.com:IIPEKOLICT/safe.git
cd safe
```

### Update DI dependencies with active watcher

Requirements:
- Flutter 3+

```shell
flutter pub get
flutter packages pub run build_runner watch --delete-conflicting-outputs
```

### Update DI dependencies

Requirements:
- Flutter 3+

```shell
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Generate Google OAuth token

Requirements:
- keystore folder inside project

```shell
chmod +x scripts/google/generate_google_oauth_token.sh
generate_google_oauth_token.sh $GOOGLE_PRIVATE_KEY_PATH $GOOGLE_PRIVATE_KEY_PASSWORD $GOOGLE_SERVICE_ACCOUNT
```

You can find generated token in `keystore/safe/google/token.txt` and `local.env` locations

### Get build arguments

Requirements:
- keystore folder inside project
- generated Google OAuth token

```shell
chmod +x scripts/google/get_build_arguments.sh
scripts/google/get_build_arguments.sh \
$PLATFORM \
$GOOGLE_BUCKET_NAME \
${GOOGLE_OAUTH_TOKEN || path to file with it} \
keystore /
```

You can find generated build arguments in `keystore/safe/$PLATFORM/build-arguments.txt` location

### Increment build number

Requirements:
- generated Google OAuth token

```shell
chmod +x scripts/google/inc_build_number.sh
scripts/google/inc_build_number.sh \
${GOOGLE_OAUTH_TOKEN || path to file with it} \
$GOOGLE_BUCKET_NAME \
$GOOGLE_BUILD_NUMBER_FILE /
```

You can find build number in `local.env` location

### Build web version

Requirements:
- Flutter 3+
- generated build arguments for web

```shell
chmod +x scripts/web/build.sh
scripts/web/build.sh . dist $BUILD_ARGUMENTS
```

You can find generated bundle in `build/web` and `dist/web` locations

### Build android version

Requirements:
- Flutter 3+
- generated build arguments for android

```shell
chmod +x scripts/android/prebuild.sh
chmod +x scripts/android/build.sh
scripts/android/prebuild.sh . $ANDROID_RELEASE_SIGN_KEY_PATH
scripts/android/build.sh $BUNDLE_NAME . dist $BUILD_ARGUMENTS
```

You can find:

- generated APK file in:
  - `build/app/outputs/flutter-apk/app-release.apk` location
  - `dist/android/$BUNDLE_NAME.apk` location
- generated AAB file in:
  - `build/app/outputs/bundle/release/app-release.aab` location
  - `dist/android/$BUNDLE_NAME.aab` location

### Build for all platforms

Requirements:
- Flutter 3+
- keystore folder inside project

```shell
chmod +x scripts/local.sh
scripts/local.sh $GOOGLE_PRIVATE_KEY_PASSWORD $GOOGLE_SERVICE_ACCOUNT $GOOGLE_BUCKET_NAME $GOOGLE_BUILD_NUMBER_FILE
```

You can find:

- generated web bundle in:
  - `build/web` location
  - `dist/web` location
- generated APK file in:
  - `build/app/outputs/flutter-apk/app-release.apk` location
  - `dist/android/safe-local.apk` location
- generated AAB file in:
  - `build/app/outputs/bundle/release/app-release.aab` location
  - `dist/android/safe-local.aab` location
