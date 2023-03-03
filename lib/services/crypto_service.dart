import 'dart:convert';

class CryptoService {
  static final Codec<String, String> _codec = utf8.fuse(base64);

  static String encode(String value) => _codec.encode(value);
  static String decode(String value) => _codec.decode(value);
}
