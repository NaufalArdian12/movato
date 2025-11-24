import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../security/token_storage.dart';
import 'user_model.dart';

class UserService {
  final _storage = TokenStorage();
  final String baseUrl = "https://your-api-url.com"; // ganti sesuai API

  Future<UserModel> getMe() async {
    final token = await _storage.readAccess();
    final url = Uri.parse("$baseUrl/me");

    final res = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to load profile");
    }

    final data = jsonDecode(res.body);
    return UserModel.fromJson(data["data"]);
  }
}
