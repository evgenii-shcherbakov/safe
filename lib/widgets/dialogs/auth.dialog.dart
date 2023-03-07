import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/di/app.module.dart';
import 'package:safe/view_models/auth_dialog.view_model.dart';
import 'package:safe/widgets/dialogs/base/base.dialog.dart';

import '../components/text_input.component.dart';

class AuthDialog extends StatelessWidget {
  final bool _isRegister;

  const AuthDialog(this._isRegister, {super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AuthDialogViewModel>();

    return BaseDialog(
      title: Center(
        child: Text(_isRegister ? 'Регистрация' : 'Вход в аккаунт'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextInputComponent(
              onInput: viewModel.setEmail,
              hintText: 'E-mail',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextInputComponent(
              onInput: viewModel.setPassword,
              hintText: 'Пароль',
              isPassword: true,
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Закрыть'),
        ),
        ElevatedButton(
          onPressed: viewModel.submit(_isRegister),
          child: const Text('ОК'),
        ),
      ],
    );
  }

  static Widget onCreate(bool isRegister) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<AuthDialogViewModel>(param1: context),
      child: AuthDialog(isRegister),
    );
  }
}
