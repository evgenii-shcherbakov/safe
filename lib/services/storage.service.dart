import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../di/app.module.dart';

@LazySingleton()
class StorageService {
  static const String _credentials = 'CREDENTIALS';

  final Future<SharedPreferences> _sharedPreferences = injector.getAsync();

  Future<AuthCredential?> getCredentialsOrNull() async {
    try {
      final String? encodedCredentials = (await _sharedPreferences).getString(_credentials);

      if (encodedCredentials == null) return null;

      final Map<String, dynamic> json = jsonDecode(encodedCredentials);

      return AuthCredential(
        providerId: json['providerId'],
        signInMethod: json['signInMethod'],
        accessToken: json['accessToken'],
        token: json['token'],
      );
    } catch (error) {
      return null;
    }
  }

  Future<void> saveCredentials(AuthCredential credentials) async {
    await (await _sharedPreferences).setString(_credentials, jsonEncode(credentials.asMap()));
  }

  Future<void> removeCredentials() async {
    await (await _sharedPreferences).remove(_credentials);
  }
}
