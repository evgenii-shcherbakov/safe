import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safe/widgets/pages/auth.page.dart';
import 'package:safe/widgets/pages/home.page.dart';

import '../constants/common.dart';
import '../enums/route.enum.dart';
import '../shared/utils.dart';

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
      theme: _theme,
      routerConfig: _router,
    );
  }

  static final ThemeData _theme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: Colors.blue,
    ),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Color.lerp(Colors.black, Colors.white, 0.04),
    ),
    cardTheme: CardTheme(
      color: Color.lerp(Colors.black, Colors.white, 0.08),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Color.lerp(Colors.black, Colors.white, 0.12),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      alignment: isMobile() ? Alignment.bottomCenter : null,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
    ),
  );
}
