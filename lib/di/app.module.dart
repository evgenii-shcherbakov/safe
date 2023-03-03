import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:safe/di/app.module.config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/environment.dart';

final injector = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async => injector.init();

@module
abstract class AppModule {
  static const Duration _requestTimeout = Duration(seconds: 30);

  @lazySingleton
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;

  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @lazySingleton
  Future<SharedPreferences> get sharedPrefs => SharedPreferences.getInstance();

  @lazySingleton
  Dio get dio => Dio(
        BaseOptions(
          baseUrl: backendUrl,
          receiveTimeout: _requestTimeout,
          connectTimeout: _requestTimeout,
        ),
      );
}
