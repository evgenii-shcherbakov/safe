// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:dio/dio.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:flutter/material.dart' as _i11;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:safe/repositories/card.repository.dart' as _i12;
import 'package:safe/services/auth.service.dart' as _i9;
import 'package:safe/services/storage.service.dart' as _i8;
import 'package:safe/state/auth.state.dart' as _i3;
import 'package:safe/view_models/auth.view_model.dart' as _i10;
import 'package:safe/view_models/auth_dialog.view_model.dart' as _i13;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import 'app.module.dart' as _i14; // ignore_for_file: unnecessary_lambdas

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
    gh.lazySingleton<_i4.Dio>(() => appModule.dio);
    gh.lazySingleton<_i5.FirebaseAuth>(() => appModule.firebaseAuth);
    gh.lazySingleton<_i6.FirebaseFirestore>(() => appModule.firebaseFirestore);
    gh.lazySingletonAsync<_i7.SharedPreferences>(() => appModule.sharedPrefs);
    gh.lazySingleton<_i8.StorageService>(() => _i8.StorageService());
    gh.lazySingleton<_i9.AuthService>(
        () => _i9.AuthService(gh<_i5.FirebaseAuth>()));
    gh.factoryParam<_i10.AuthViewModel, _i11.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i10.AuthViewModel(
          context,
          gh<_i9.AuthService>(),
          gh<_i3.AuthState>(),
          gh<_i8.StorageService>(),
        ));
    gh.lazySingleton<_i12.CardRepository>(
        () => _i12.CardRepository(gh<_i6.FirebaseFirestore>()));
    gh.factoryParam<_i13.AuthDialogViewModel, _i11.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i13.AuthDialogViewModel(
          context,
          gh<_i9.AuthService>(),
          gh<_i3.AuthState>(),
          gh<_i8.StorageService>(),
        ));
    return this;
  }
}

class _$AppModule extends _i14.AppModule {}
