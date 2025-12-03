import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../security/token_storage.dart';
import 'user_model.dart';

class UserService {
  final _storage = TokenStorage();

  final String baseUrl = 
      "https://eduapp-api-master-xgvx7r.laravel.cloud/api/v1/auth";


  // Login
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/login");

    final res = await http.post(
      url,
      headers: {"Accept": "application/json"},
      body: {"email": email, "password": password},
    );

    if (res.statusCode != 200) {
      throw Exception("Login gagal: ${res.body}");
    }

    final data = jsonDecode(res.body);

    final access = data["access_token"];
    final refresh = data["refresh_token"];

    if (access == null) {
      throw Exception("Token tidak diterima dari server");
    }

    await _storage.save(access, refresh ?? "");

    return UserModel.fromJson(data["user"]);
  }

  // GET PROFILE / ME
  Future<UserModel> getMe() async {
    final token = await _storage.readAccess();

    if (token == null) {
      throw Exception("Token tidak ditemukan, login ulang");
    }

    final url = Uri.parse("$baseUrl/me");

    final res = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    debugPrint("getMe() STATUS => ${res.statusCode}");
    debugPrint("getMe() BODY => ${res.body}");

    if (res.statusCode != 200) {
      throw Exception("Gagal memuat data user");
    }

    final json = jsonDecode(res.body);

    final userJson = json["data"] ?? json["user"] ?? json;
    return UserModel.fromJson(userJson);
  }
}
