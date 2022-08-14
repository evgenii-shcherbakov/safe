import 'dart:convert';

import 'package:http/http.dart';
import 'package:safe_client/core/base_repository.dart';
import 'package:safe_client/models/secret_model.dart';

class SecretRepository extends BaseRepository {
  final String endPoint = "secrets";

  Future<List<SecretModel>> getAll() async {
    Response response = await get(Uri.parse("$baseUrl/$endPoint"), headers: headers);

    if (response.statusCode != 200) {
      throw Exception("Can't load secrets");
    }

    return (jsonDecode(response.body) as List<dynamic>)
        .map((dynamic json) => SecretModel.fromJson(json))
        .toList();
  }
}
