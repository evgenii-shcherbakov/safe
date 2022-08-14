import 'package:safe_client/services/crypto_service.dart';

class CardModel {
  final int id;
  String name;
  String description;
  String type;
  String number;
  String vcc;
  String pin;
  String securityCode;
  DateTime expiredAt;
  int price;

  CardModel({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.type = '',
    this.number = '',
    this.vcc = '',
    this.pin = '',
    this.securityCode = '',
    required this.expiredAt,
    this.price = 0,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      number: CryptoService.decode(json['number']),
      vcc: CryptoService.decode(json['vcc']),
      pin: CryptoService.decode(json['pin']),
      securityCode: CryptoService.decode(json['securityCode']),
      expiredAt: DateTime.parse(json['expiredAt']),
      price: int.parse(json['price']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'number': CryptoService.encode(number),
      'vcc': CryptoService.encode(vcc),
      'pin': CryptoService.encode(pin),
      'securityCode': CryptoService.encode(securityCode),
      'expiredAt': expiredAt.toString(),
      'price': price,
    };
  }
}
