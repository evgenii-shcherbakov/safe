import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:safe/shared/credentials.dart';

@LazySingleton()
class AuthService {
  final FirebaseAuth _instance;

  AuthService(this._instance);

  // User? getUser() => _instance.currentUser;
  // Stream<User?> getUserStream() => _instance.authStateChanges();

  Future<UserCredential> register(String email, String password) async {
    return _instance.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> login(String email, String password) async {
    return _instance.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> authViaSavedCredentials(Credentials credentials) async {
    return login(credentials.getEmail(), credentials.getPassword());
  }

  Future<void> logout() async {
    await _instance.signOut();
  }
}
