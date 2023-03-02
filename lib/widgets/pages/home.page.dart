import 'package:flutter/material.dart';

import '../../constants/common.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        leading: TextButton(
          onPressed: null,
          child: const Icon(Icons.arrow_back_sharp),
        ),
      ),
      body: const Text('Home page'),
    );
  }

  static Widget onCreate() {
    return const HomePage();

    // return ChangeNotifierProvider(
    //   create: (BuildContext context) => injector.get<AuthViewModel>(param1: context),
    //   child: const AuthPage(),
    // );
  }
}
