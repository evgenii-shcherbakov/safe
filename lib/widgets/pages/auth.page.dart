import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:safe/widgets/dialogs/auth.dialog.dart';

import '../../constants/common.dart';
import '../../di/app.module.dart';
import '../../view_models/auth.view_model.dart';
import '../components/loader.component.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  Future<void> Function() _showDialog(BuildContext context, {bool isRegister = false}) {
    return () async {
      await showDialog(
        context: context,
        builder: (BuildContext ctx) => AuthDialog.onCreate(isRegister),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AuthViewModel>();

    return Scaffold(
        appBar: AppBar(
          title: const Text(appName),
          leading: TextButton(
            onPressed: () => SystemNavigator.pop(animated: true),
            child: const Icon(Icons.arrow_back_sharp),
          ),
        ),
        body: viewModel.isLoading
            ? const LoaderComponent()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    title: ElevatedButton(
                      onPressed: _showDialog(context),
                      child: const Text('Войти'),
                    ),
                  ),
                  ListTile(
                    title: ElevatedButton(
                      onPressed: _showDialog(context, isRegister: true),
                      child: const Text('Зарегистрироваться'),
                    ),
                  ),
                ],
              ));
  }

  static Widget onCreate() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<AuthViewModel>(param1: context),
      child: const AuthPage(),
    );
  }
}
