import 'package:flutter/material.dart';
import 'package:safe_client/models/secret_model.dart';
import 'package:safe_client/repositories/main_repository.dart';
import 'package:safe_client/repositories/secret_repository.dart';

class SecretsPage extends StatefulWidget {
  const SecretsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SecretsPage> createState() => _SecretsPageState();
}

class _SecretsPageState extends State<SecretsPage> {
  late Future<List<SecretModel>> futureSecrets;

  String message = 'NOT_LOADED';

  @override
  void initState() {
    super.initState();
    futureSecrets = _secretRepository.getAll();
  }

  final SecretRepository _secretRepository = SecretRepository();
  final MainRepository _mainRepository = MainRepository();

  void _incrementCounter() async {
    bool hasConnection = await _mainRepository.healthCheck();

    setState(() {
      message = hasConnection ? 'SUCCESS' : 'NO_RESULT';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<List<SecretModel>>(
          future: futureSecrets,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(children: [
                Text(snapshot.data!.length.toString()),
                Text(message),
                ...snapshot.data!.map((SecretModel secret) => Text(secret.name)).toList(),
              ]);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
