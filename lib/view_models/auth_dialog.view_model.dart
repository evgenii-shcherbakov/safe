import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:safe/services/storage.service.dart';
import 'package:safe/shared/credentials.dart';
import 'package:safe/view_models/base/base.view_model.dart';
import 'package:safe/view_models/base/loadable.view_model.dart';

import '../enums/route.enum.dart';
import '../services/auth.service.dart';
import '../state/auth.state.dart';

@Injectable()
class AuthDialogViewModel extends BaseViewModel with LoadableViewModel {
  final AuthService _authService;
  final AuthState _authState;
  final StorageService _storageService;

  AuthDialogViewModel(@factoryParam super.context, this._authService, this._authState, this._storageService);

  String _email = '';
  String _password = '';

  bool get isAuthSubmitAllowed => _email.isNotEmpty && _password.isNotEmpty;

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void _resetForm() {
    _email = '';
    _password = '';
    notifyListeners();
  }

  @override
  void onInit() {
    _authState.user$.subscribe(_userSubscriber, lazy: false);
  }

  void _userSubscriber(User? user) {
    if (user != null) {
      context.go(RouteEnum.home.value);
    }
  }

  Future<void> Function() submit(bool isRegister) {
    return () async {
      try {
        final UserCredential credentials =
            isRegister ? await _authService.register(_email, _password) : await _authService.login(_email, _password);

        if (credentials.user != null) {
          await _storageService.saveCredentials(Credentials.create(email: _email, password: _password));
        }

        _resetForm();
        _authState.setUser(credentials.user);
      } catch (exception) {
        onException(exception);
      }
    };
  }

  // Future<void> logout() async {
  //   await _authService.logout();
  //   await _storageService.removeCredentials();
  //   _authState.reset();
  // }

  @override
  void dispose() {
    _authState.user$.unsubscribe(_userSubscriber);
    super.dispose();
  }
}
