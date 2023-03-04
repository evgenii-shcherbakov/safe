import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe/models/base/entity.dart';
import 'package:safe/services/crypto.service.dart';

import '../di/app.module.dart';

class Card extends Entity {
  String name;
  String description;
  String type;
  String number;
  String vcc;
  String pin;
  String securityCode;
  String expiredAt;
  int price;
  String priceCurrency;

  Card({
    String id = '',
    this.name = '',
    this.description = '',
    this.type = '',
    this.number = '',
    this.vcc = '',
    this.pin = '',
    this.securityCode = '',
    this.expiredAt = '',
    this.price = 0,
    this.priceCurrency = '',
  }) : super(id);

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'type': type,
      'number': _cryptoService.encode(number),
      'vcc': _cryptoService.encode(vcc),
      'pin': _cryptoService.encode(pin),
      'securityCode': _cryptoService.encode(securityCode),
      'expiredAt': expiredAt,
      'price': price,
      'priceCurrency': priceCurrency,
    };
  }

  factory Card.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final String id = snapshot.id;
    final data = snapshot.data();

    return Card(
      id: id,
      name: data?['name'] ?? '',
      description: data?['description'] ?? '',
      type: data?['type'] ?? '',
      number: _cryptoService.decode(data?['number'] ?? ''),
      vcc: _cryptoService.decode(data?['vcc'] ?? ''),
      pin: _cryptoService.decode(data?['pin'] ?? ''),
      securityCode: _cryptoService.decode(data?['securityCode'] ?? ''),
      expiredAt: data?['expiredAt'] ?? '',
      price: data?['price'] ?? 0,
      priceCurrency: data?['priceCurrency'] ?? '',
    );
  }

  static Map<String, dynamic> Function(Card, SetOptions?) get toFirestore {
    return (Card card, SetOptions? _) => card.toJson();
  }

  static const String collectionName = 'cards';
  static final CryptoService _cryptoService = injector.get();
}
