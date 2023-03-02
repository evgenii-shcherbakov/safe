import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../shared/observable.dart';
import '../shared/stream.dart';

@LazySingleton()
class AuthState {
  final Stream<bool> _isAuth$ = Stream(false);
  final Stream<User?> _user$ = Stream(null);

  Observable<bool> get isAuth$ {
    return _isAuth$;
  }

  Observable<User?> get user$ {
    return _user$;
  }

  User? getUserOrNull() => _user$.get();
  User getUser() => _user$.get() ?? (throw Exception());

  void setUser(User? user) {
    _isAuth$.set(user != null);
    _user$.set(user);
  }

  void reset() {
    _isAuth$.set(false);
    _user$.set(null);
  }
}
