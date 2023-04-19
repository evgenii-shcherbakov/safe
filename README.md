_safe_

# Flutter app

Cross-platform app for store passwords

### Tech stack

- Dart
- Flutter
- Provider
- Injectable
- Firebase

### Repository secrets

> **AWS Credentials**
>
> - `AWS_ACCESS_KEY_ID` access key id for use AWS
> - `AWS_SECRET_ACCESS_KEY` secret access key for use AWS
> - `AWS_REGION` AWS region

> **Android signing**
> 
> - `KEYSTORE_GIT_REPOSITORY` name of git repository with keystore
> - `KEYSTORE_ACCESS_TOKEN` token for get access to keystore repository
> - `KEYSTORE_PASSWORD` password of used keystore
> - `RELEASE_SIGN_KEY_ALIAS` used alias for sign app using keystore
> - `RELEASE_SIGN_KEY_PASSWORD` used password for sign app using keystore

> **Firebase credentials**
> 
> All platforms:
> - `FIREBASE_MESSAGING_SENDER_ID`
> - `FIREBASE_PROJECT_ID`
> - `FIREBASE_STORAGE_BUCKET`
> 
> Android:
> - `FIREBASE_ANDROID_API_KEY`
> - `FIREBASE_ANDROID_APP_ID`
> 
> Web:
> - `FIREBASE_AUTH_DOMAIN`
> - `FIREBASE_WEB_API_KEY`
> - `FIREBASE_WEB_APP_ID`
> 
> IOS & MacOS:
> - `FIREBASE_APPLE_API_KEY`
> - `FIREBASE_APPLE_APP_ID`
> - `FIREBASE_IOS_CLIENT_ID`
> - `FIREBASE_IOS_BUNDLE_ID`

### Environment variables

> Android (build)
> - `FIREBASE_API_KEY`
> - `FIREBASE_APP_ID`
> - `FIREBASE_MESSAGING_SENDER_ID`
> - `FIREBASE_PROJECT_ID`
> - `FIREBASE_STORAGE_BUCKET`

> Android (signing)
> - `KEYSTORE_GIT_REPOSITORY` (optional)
> - `KEYSTORE_ACCESS_TOKEN` (optional)
> - `KEYSTORE_PASSWORD` (optional)
> - `RELEASE_SIGN_KEY_ALIAS` (optional)
> - `RELEASE_SIGN_KEY_PASSWORD` (optional)

> Web (build)
> - `FIREBASE_API_KEY`
> - `FIREBASE_APP_ID`
> - `FIREBASE_MESSAGING_SENDER_ID`
> - `FIREBASE_AUTH_DOMAIN`
> - `FIREBASE_PROJECT_ID`
> - `FIREBASE_STORAGE_BUCKET`

> IOS & MacOS (build)
> - `FIREBASE_API_KEY`
> - `FIREBASE_APP_ID`
> - `FIREBASE_MESSAGING_SENDER_ID`
> - `FIREBASE_PROJECT_ID`
> - `FIREBASE_STORAGE_BUCKET`
> - `FIREBASE_IOS_CLIENT_ID`
> - `FIREBASE_IOS_BUNDLE_ID`

### Load project

```shell
git clone git@github.com:IIPEKOLICT/safe.git
cd safe
```

### Update DI dependencies with active watcher (needed Flutter 3+)

```shell
cd frontend
flutter pub get
flutter packages pub run build_runner watch --delete-conflicting-outputs
```

### Update DI dependencies (needed Flutter 3+)

```shell
cd frontend
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Build web-version (needed Flutter 3+)

```shell
cd frontend
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
flutter build web --release --base-href "/$BASE_URL/" \
--dart-define=FIREBASE_API_KEY="$FIREBASE_API_KEY" \
--dart-define=FIREBASE_APP_ID="$FIREBASE_APP_ID" \
--dart-define=FIREBASE_MESSAGING_SENDER_ID="$FIREBASE_MESSAGING_SENDER_ID" \
--dart-define=FIREBASE_AUTH_DOMAIN="$FIREBASE_AUTH_DOMAIN" \
--dart-define=FIREBASE_PROJECT_ID="$FIREBASE_PROJECT_ID" \
--dart-define=FIREBASE_STORAGE_BUCKET="$FIREBASE_STORAGE_BUCKET" /
```

You can find generated bundle in `build/web` location

### Build android-version (needed Flutter 3+)

```shell
cd frontend
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
flutter build apk \
--dart-define=FIREBASE_API_KEY="$FIREBASE_API_KEY" \
--dart-define=FIREBASE_APP_ID="$FIREBASE_APP_ID" \
--dart-define=FIREBASE_MESSAGING_SENDER_ID="$FIREBASE_MESSAGING_SENDER_ID" \
--dart-define=FIREBASE_PROJECT_ID="$FIREBASE_PROJECT_ID" \
--dart-define=FIREBASE_STORAGE_BUCKET="$FIREBASE_STORAGE_BUCKET" /
flutter build appbundle \
--dart-define=FIREBASE_API_KEY="$FIREBASE_API_KEY" \
--dart-define=FIREBASE_APP_ID="$FIREBASE_APP_ID" \
--dart-define=FIREBASE_MESSAGING_SENDER_ID="$FIREBASE_MESSAGING_SENDER_ID" \
--dart-define=FIREBASE_PROJECT_ID="$FIREBASE_PROJECT_ID" \
--dart-define=FIREBASE_STORAGE_BUCKET="$FIREBASE_STORAGE_BUCKET" /
```

You can find:

- generated APK file in `build/app/outputs/flutter-apk/app-release.apk` location
- generated AAB file in `build/app/outputs/bundle/release/app-release.aab` location
