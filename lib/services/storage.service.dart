import 'package:injectable/injectable.dart';
import 'package:safe/shared/credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../di/app.module.dart';

@LazySingleton()
class StorageService {
  static const String _credentials = 'CREDENTIALS';

  final Future<SharedPreferences> _sharedPreferences = injector.getAsync();

  Future<Credentials?> getCredentialsOrNull() async {
    try {
      final String? encodedCredentials = (await _sharedPreferences).getString(_credentials);
      if (encodedCredentials == null) return null;
      return Credentials.fromJson(encodedCredentials);
    } catch (_) {
      return null;
    }
  }

  Future<void> saveCredentials(Credentials credentials) async {
    await (await _sharedPreferences).setString(_credentials, credentials.toJson());
  }

  Future<void> removeCredentials() async {
    await (await _sharedPreferences).remove(_credentials);
  }
}
