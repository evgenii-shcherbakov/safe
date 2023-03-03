import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe/models/base/entity.dart';
import 'package:safe/services/crypto_service.dart';

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
      'number': CryptoService.encode(number),
      'vcc': CryptoService.encode(vcc),
      'pin': CryptoService.encode(pin),
      'securityCode': CryptoService.encode(securityCode),
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
      number: CryptoService.decode(data?['number'] ?? ''),
      vcc: CryptoService.decode(data?['vcc'] ?? ''),
      pin: CryptoService.decode(data?['pin'] ?? ''),
      securityCode: CryptoService.decode(data?['securityCode'] ?? ''),
      expiredAt: data?['expiredAt'] ?? '',
      price: data?['price'] ?? 0,
      priceCurrency: data?['priceCurrency'] ?? '',
    );
  }

  static const String collectionName = 'cards';

  static Map<String, dynamic> Function(Card, SetOptions?) get toFirestore {
    return (Card card, SetOptions? _) => card.toJson();
  }
}
