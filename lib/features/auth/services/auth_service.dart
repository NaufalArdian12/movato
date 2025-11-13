import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:movato/src/core/network/api_client.dart';

class AuthService {
  final _api = ApiClient();

  Future<void> login({required String email, required String password}) async {
    String deviceName = 'mobile';
    try {
      final info = await PackageInfo.fromPlatform();
      deviceName = 'movato_${info.appName}_${info.version}';
    } catch (_) {}

    try {
      final res = await _api.dio.post(
        '/v1/auth/login',
        data: {'email': email, 'password': password, 'device_name': deviceName},
      );

      final data = res.data['data'];
      final token = data['token'] as String?;
      if (token == null || token.isEmpty) {
        throw Exception('Token tidak ditemukan');
      }
      await _api.saveToken(token);
    } on DioException catch (e) {
      final msg = _extractMessage(e);
      throw Exception(msg);
    }
  }

  Future<Map<String, dynamic>> me() async {
    try {
      final res = await _api.dio.get('/v1/auth/me');
      return (res.data['data'] as Map).cast<String, dynamic>();
    } on DioException catch (e) {
      throw Exception(_extractMessage(e));
    }
  }

  Future<void> logout() async {
    await _api.clearToken();
    // optional: panggil endpoint revoke token kalau ada
  }

  String _extractMessage(DioException e) {
    // Tangkap pesan khusus dari backend kamu
    final data = e.response?.data;
    final code = data is Map ? data['code'] : null;
    final message = data is Map
        ? (data['message'] ?? data['error'] ?? e.message)
        : e.message;

    if (code == 'INVALID_CREDENTIALS') return 'Email atau password salah';
    if (code == 'EMAIL_NOT_VERIFIED') return 'Email belum terverifikasi';
    return '$message';
  }

  //sign up
  Future<void> signup({
    required String email,
    required String username,
    required String password,
  }) async {
    String deviceName = 'mobile';
    try {
      final info = await PackageInfo.fromPlatform();
      deviceName = 'movato_${info.appName}_${info.version}';
    } catch (_) {}
    try {
      final res = await _api.dio.post(
        '/v1/auth/signup',
        data: {
          'email': email,
          'username': username,
          'password': password,
          'device_name': deviceName,
        },
      );

      final data = res.data['data'];
      final token = data['token'] as String?;
      if (token == null || token.isEmpty) {
        throw Exception('Token tidak ditemukan');
      }
      await _api.saveToken(token);
    } on DioException catch (e) {
      final msg = _extractMessage(e);
      throw Exception(msg);
    }
  }
}
