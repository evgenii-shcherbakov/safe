import '../di/app.module.dart';
import '../services/crypto.service.dart';

class Secret {
  final int id;
  String name;
  String description;
  String url;
  String email;
  String login;
  String phone;
  String password;

  Secret({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.url = '',
    this.email = '',
    this.login = '',
    this.phone = '',
    this.password = '',
  });

  factory Secret.fromJson(Map<String, dynamic> json) {
    return Secret(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      url: json['url'],
      email: _cryptoService.decode(json['email']),
      login: _cryptoService.decode(json['login']),
      phone: _cryptoService.decode(json['phone']),
      password: _cryptoService.decode(json['password']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'url': url,
      'email': _cryptoService.encode(email),
      'login': _cryptoService.encode(login),
      'phone': _cryptoService.encode(phone),
      'password': _cryptoService.encode(password),
    };
  }

  static final CryptoService _cryptoService = injector.get();
}
