import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:safe/services/storage.service.dart';
import 'package:safe/view_models/base/base.view_model.dart';
import 'package:safe/view_models/base/loadable.view_model.dart';

import '../enums/route.enum.dart';
import '../services/auth.service.dart';
import '../state/auth.state.dart';

@Injectable()
class AuthViewModel extends BaseViewModel with LoadableViewModel {
  final AuthService _authService;
  final AuthState _authState;
  final StorageService _storageService;

  AuthViewModel(@factoryParam super.context, this._authService, this._authState, this._storageService);

  @override
  void onInit() {
    _authState.user$.subscribe(_userSubscriber, lazy: false);
    _auth();
  }

  void _userSubscriber(User? user) {
    if (user == null) {
      toggleIsLoading();
      return notifyListeners();
    }

    context.go(RouteEnum.home.value);
  }

  Future<void> _auth() async {
    final AuthCredential? credentials = await _storageService.getCredentialsOrNull();

    if (credentials == null) {
      return _authState.reset();
    }

    final UserCredential userCredentials = await _authService.authViaSavedCredentials(credentials);

    if (userCredentials.credential != null) {
      await _storageService.saveCredentials(userCredentials.credential!);
    }

    _authState.setUser(userCredentials.user);
  }

  @override
  void dispose() {
    _authState.user$.unsubscribe(_userSubscriber);
    super.dispose();
  }
}
