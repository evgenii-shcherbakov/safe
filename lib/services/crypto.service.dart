import 'dart:convert';

import 'package:injectable/injectable.dart';

@LazySingleton()
class CryptoService {
  final Codec<String, String> _codec;

  CryptoService(this._codec);

  String encode(String value) => _codec.encode(value);
  String decode(String value) => _codec.decode(value);
}
