import '../services/crypto_service.dart';

class SecretModel {
  final int id;
  String name;
  String description;
  String url;
  String email;
  String login;
  String phone;
  String password;

  SecretModel({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.url = '',
    this.email = '',
    this.login = '',
    this.phone = '',
    this.password = '',
  });

  factory SecretModel.fromJson(Map<String, dynamic> json) {
    return SecretModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      url: json['url'],
      email: CryptoService.decode(json['email']),
      login: CryptoService.decode(json['login']),
      phone: CryptoService.decode(json['phone']),
      password: CryptoService.decode(json['password']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'url': url,
      'email': CryptoService.encode(email),
      'login': CryptoService.encode(login),
      'phone': CryptoService.encode(phone),
      'password': CryptoService.encode(password),
    };
  }
}
