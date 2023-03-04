import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safe/models/base/entity.dart';

abstract class FirestoreRepository<E extends Entity> {
  final FirebaseFirestore _instance;
  final String _collectionName;
  final E Function(DocumentSnapshot<Map<String, dynamic>>, SnapshotOptions?) _fromFirestore;
  final Map<String, dynamic> Function(E, SetOptions?) _toFirestore;

  FirestoreRepository(this._instance, this._collectionName, this._fromFirestore, this._toFirestore);

  @protected
  CollectionReference<E> get collection {
    return _instance.collection(_collectionName).withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        );
  }

  Stream<QuerySnapshot<E>> getStream() {
    return collection.snapshots();
  }

  Future<List<E>> getAll() async {
    return (await collection.get()).docs.map((QueryDocumentSnapshot<E> snapshot) => snapshot.data()).toList();
  }

  Future<E?> getById(String id) async {
    return (await collection.doc(id).get()).data();
  }

  Future<E?> create(E entity) async {
    return (await (await collection.add(entity)).get()).data();
  }

  Future<E?> updateById(String id, E entity) async {
    await collection.doc(id).update(entity.toJson());
    return getById(id);
  }

  Future<String> deleteById(String id) async {
    await collection.doc(id).delete();
    return id;
  }
}
