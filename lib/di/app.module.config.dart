// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:convert' as _i4;

import 'package:cloud_firestore/cloud_firestore.dart' as _i8;
import 'package:dio/dio.dart' as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i7;
import 'package:flutter/material.dart' as _i13;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:safe/repositories/card.repository.dart' as _i14;
import 'package:safe/services/auth.service.dart' as _i11;
import 'package:safe/services/crypto.service.dart' as _i5;
import 'package:safe/services/storage.service.dart' as _i10;
import 'package:safe/state/auth.state.dart' as _i3;
import 'package:safe/view_models/auth.view_model.dart' as _i12;
import 'package:safe/view_models/auth_dialog.view_model.dart' as _i15;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import 'app.module.dart' as _i16; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.lazySingleton<_i3.AuthState>(() => _i3.AuthState());
    gh.lazySingleton<_i4.Codec<String, String>>(() => appModule.codec);
    gh.lazySingleton<_i5.CryptoService>(
        () => _i5.CryptoService(gh<_i4.Codec<String, String>>()));
    gh.lazySingleton<_i6.Dio>(() => appModule.dio);
    gh.lazySingleton<_i7.FirebaseAuth>(() => appModule.firebaseAuth);
    gh.lazySingleton<_i8.FirebaseFirestore>(() => appModule.firebaseFirestore);
    gh.lazySingletonAsync<_i9.SharedPreferences>(() => appModule.sharedPrefs);
    gh.lazySingleton<_i10.StorageService>(() => _i10.StorageService());
    gh.lazySingleton<_i11.AuthService>(
        () => _i11.AuthService(gh<_i7.FirebaseAuth>()));
    gh.factoryParam<_i12.AuthViewModel, _i13.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i12.AuthViewModel(
          context,
          gh<_i11.AuthService>(),
          gh<_i3.AuthState>(),
          gh<_i10.StorageService>(),
        ));
    gh.lazySingleton<_i14.CardRepository>(
        () => _i14.CardRepository(gh<_i8.FirebaseFirestore>()));
    gh.factoryParam<_i15.AuthDialogViewModel, _i13.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i15.AuthDialogViewModel(
          context,
          gh<_i11.AuthService>(),
          gh<_i3.AuthState>(),
          gh<_i10.StorageService>(),
        ));
    return this;
  }
}

class _$AppModule extends _i16.AppModule {}
