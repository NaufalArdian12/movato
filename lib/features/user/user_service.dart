import 'package:dio/dio.dart';
import 'package:movato/security/token_storage.dart';
import 'user_model.dart';

class UserService {
  final Dio dio;
  final TokenStorage storage;

  UserService(this.dio, this.storage);

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await dio.post(
        "/auth/login",
        data: {"email": email, "password": password},
      );

      final data = res.data;

      final access = data["access_token"];
      final refresh = data["refresh_token"];

      if (access == null) {
        throw Exception("Server tidak memberikan access token");
      }

      await storage.save(access, refresh ?? "");

      return UserModel.fromJson(data["user"]);
    } on DioException catch (e) {
      throw Exception("Login gagal: ${e.response?.data ?? e.message}");
    }
  }

  Future<UserModel> getMe() async {
    final token = await storage.readAccess();
    if (token == null) {
      throw Exception("Token tidak ditemukan, login ulang");
    }

    try {
      final res = await dio.get(
        "/profile",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      final json = res.data;
      // Backend kamu: { "status": "success", "data": { "user": { ... } } }
      final userJson = (json?['data']?['user']) ?? json?['data'] ?? json;

      if (userJson == null) {
        throw Exception("Response tidak berisi user");
      }

      return UserModel.fromJson(userJson as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception("Gagal memuat profile: ${e.response?.data ?? e.message}");
    } catch (e) {
      throw Exception("Error loading user: $e");
    }
  }
}
