import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safe/enums/route.enum.dart';

import '../../constants/common.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        leading: TextButton(
          onPressed: () => context.go(RouteEnum.auth.value),
          child: const Icon(Icons.arrow_back_sharp),
        ),
      ),
      body: const Center(
        child: Text('Home page'),
      ),
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
