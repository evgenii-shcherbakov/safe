import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../models/card.dart';
import 'base/firestore.repository.dart';

@LazySingleton()
class CardRepository extends FirestoreRepository<Card> {
  CardRepository(FirebaseFirestore instance)
      : super(
          instance,
          Card.collectionName,
          Card.fromFirestore,
          Card.toFirestore,
        );
}
