import 'package:http/http.dart';
import 'package:safe_client/core/base_repository.dart';

class MainRepository extends BaseRepository {
  Future<bool> healthCheck() async {
    Response response = await get(Uri.parse('$baseUrl/test'), headers: headers);
    return response.statusCode == 200;
  }
}
