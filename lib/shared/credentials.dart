import 'dart:convert';

import 'package:safe/di/app.module.dart';
import 'package:safe/services/crypto.service.dart';

class Credentials {
  String _email;
  String _password;

  Credentials(this._email, this._password);

  factory Credentials.create({String email = '', String password = ''}) {
    return Credentials(email, password);
  }

  factory Credentials.fromJson(String stringJson) {
    final Map<String, dynamic> json = jsonDecode(stringJson);

    return Credentials(
      _cryptoService.decode(json['email']),
      _cryptoService.decode(json['password']),
    );
  }

  String getEmail() => _email;
  String getPassword() => _password;

  void setEmail(String value) {
    _email = _cryptoService.decode(value);
  }

  void setPassword(String value) {
    _password = _cryptoService.decode(value);
  }

  String toJson() {
    return jsonEncode({
      'email': _cryptoService.encode(_email),
      'password': _cryptoService.encode(_password),
    });
  }

  static final CryptoService _cryptoService = injector.get();
}
