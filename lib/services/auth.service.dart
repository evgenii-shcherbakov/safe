import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthService {
  final FirebaseAuth _instance;

  AuthService(this._instance);

  Future<UserCredential> authViaSavedCredentials(AuthCredential credentials) async {
    return _instance.signInWithCredential(credentials);
  }

  Future<UserCredential> register(String email, String password) async {
    return _instance.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> login(String email, String password) async {
    return _instance.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await _instance.signOut();
  }
}
