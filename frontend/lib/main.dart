import 'package:flutter/material.dart';
import 'package:safe_client/pages/secrets_page.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe client',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        colorScheme: const ColorScheme.dark(),
      ),
      home: const SecretsPage(title: 'Secrets'),
    );
  }
}
