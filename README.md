_safe_

# NestJS + Flutter app

App for store passwords and credentials

### Backend tech stack

- TypeScript
- NestJS
- TypeORM
- PostgreSQL

### Frontend tech stack

- Dart
- Flutter

### Repository secrets

- `HEROKU_APP_NAME` name of backend Heroku app
- `HEROKU_API_KEY` used Heroku api key for deploy backend
- `HEROKU_EMAIL` used Heroku email for deploy backend
- `KEYSTORE_GIT_REPOSITORY` name of git repository with keystore for mobile app
- `KEYSTORE_ACCESS_TOKEN` token for get access to keystore repository
- `ANDROID_KEYSTORE_PASSWORD` password of used android keystore
- `ANDROID_RELEASE_SIGN_KEY_ALIAS` used alias for sign android app using keystore
- `ANDROID_RELEASE_SIGN_KEY_PASSWORD` used password for sign android app using keystore

### Environment variables

- `PORT` used port by backend
- `DATABASE_URL`
- `SECRET_KEY` secret key, used for auth
- `PGSSLMODE` set to 'no-verify' for Heroku

### Setup database

```shell
psql -U postgres
create database safe;
\q
```

### Load project

```shell
git clone git@github.com:IIPEKOLICT/safe.git
cd safe
```

### Start backend locally (needed 16+ NodeJS)

```shell
cd backend
npm i
npm run start
```

### Start backend on heroku command (needed 16+ NodeJS)

```shell
npm run build:prod
```

### Build APK and AAB files

```shell
chmod +x ./scripts/build_android.sh
./scripts/build_android.sh $FRONTEND_NAME-$GIT_TAG_NAME
```
