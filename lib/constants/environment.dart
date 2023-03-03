import 'package:firebase_core/firebase_core.dart';

const String backendUrl = String.fromEnvironment('BACKEND_URL', defaultValue: 'http://localhost:5000');

const FirebaseOptions firebaseOptions = FirebaseOptions(
  apiKey: String.fromEnvironment('FIREBASE_API_KEY', defaultValue: ''),
  appId: String.fromEnvironment('FIREBASE_APP_ID', defaultValue: ''),
  messagingSenderId: String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID', defaultValue: ''),
  projectId: String.fromEnvironment('FIREBASE_PROJECT_ID', defaultValue: ''),
  storageBucket: bool.hasEnvironment('FIREBASE_STORAGE_BUCKET')
      ? String.fromEnvironment('FIREBASE_STORAGE_BUCKET', defaultValue: '')
      : null,
  authDomain: bool.hasEnvironment('FIREBASE_AUTH_DOMAIN')
      ? String.fromEnvironment('FIREBASE_AUTH_DOMAIN', defaultValue: '')
      : null,
  iosClientId: bool.hasEnvironment('FIREBASE_IOS_CLIENT_ID')
      ? String.fromEnvironment('FIREBASE_IOS_CLIENT_ID', defaultValue: '')
      : null,
  iosBundleId: bool.hasEnvironment('FIREBASE_IOS_BUNDLE_ID')
      ? String.fromEnvironment('FIREBASE_IOS_BUNDLE_ID', defaultValue: '')
      : null,
);
