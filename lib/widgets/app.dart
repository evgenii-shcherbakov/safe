import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safe/widgets/pages/auth.page.dart';
import 'package:safe/widgets/pages/home.page.dart';

import '../constants/common.dart';
import '../enums/route.enum.dart';

class App extends StatelessWidget {
  App({super.key});

  final _router = GoRouter(
    initialLocation: RouteEnum.auth.value,
    routes: [
      GoRoute(
        path: RouteEnum.auth.value,
        builder: (context, state) => AuthPage.onCreate(),
      ),
      GoRoute(
        path: RouteEnum.home.value,
        builder: (context, state) => HomePage.onCreate(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appName,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Colors.blue,
        ),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Color.lerp(Colors.black, Colors.white, 0.05),
        ),
        cardTheme: CardTheme(
          color: Color.lerp(Colors.black, Colors.white, 0.1),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Color.lerp(Colors.black, Colors.white, 0.15),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          alignment: !kIsWeb && (Platform.isAndroid || Platform.isIOS) ? Alignment.bottomCenter : null,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
        ),
      ),
      routerConfig: _router,
    );
  }
}
