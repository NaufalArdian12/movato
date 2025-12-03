// lib/features/auth/data/auth_service.dart
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:movato/security/token_storage.dart';

class AuthService {
  final Dio dio;
  final TokenStorage tokenStorage;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  AuthService({required this.dio, required this.tokenStorage});

  Future<String> _deviceName() async {
    try {
      final info = await PackageInfo.fromPlatform();
      return 'movato_${info.appName}_${info.version}';
    } catch (_) {
      return 'mobile';
    }
  }

  Future<void> login({required String email, required String password}) async {
    final deviceName = await _deviceName();
    try {
      final res = await dio.post(
        '/auth/login',
        data: {'email': email, 'password': password, 'device_name': deviceName},
      );

      final data = res.data['data'];
      final token = data['token'] as String?;
      if (token == null || token.isEmpty) {
        throw Exception('Token tidak ditemukan');
      }
      await tokenStorage.writeAccess(token);
    } on DioException catch (e) {
      throw Exception(_extractMessage(e));
    }
  }

  Future<Map<String, dynamic>> me() async {
    try {
      final res = await dio.get('/auth/me');
      return (res.data['data'] as Map).cast<String, dynamic>();
    } on DioException catch (e) {
      throw Exception(_extractMessage(e));
    }
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
    } catch (_) {}
    await tokenStorage.clearAccess();
  }

  String _extractMessage(DioException e) {
    final data = e.response?.data;
    final code = data is Map ? data['code'] : null;
    final message = data is Map
        ? (data['message'] ?? data['error'] ?? e.message)
        : e.message;

    if (code == 'INVALID_CREDENTIALS') return 'Email atau password salah';
    if (code == 'EMAIL_NOT_VERIFIED') return 'Email belum terverifikasi';
    return '$message';
  }

  Future<void> signup({
    required String email,
    required String username,
    required String password,
  }) async {
    final deviceName = await _deviceName();
    try {
      final res = await dio.post(
        '/auth/signup',
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
      await tokenStorage.writeAccess(token);
    } on DioException catch (e) {
      throw Exception(_extractMessage(e));
    }
  }

  Future<void> loginWithGoogle() async {
    final deviceName = await _deviceName();
    try {
      try {
        await _googleSignIn.disconnect();
      } catch (_) {}

      final account = await _googleSignIn.signIn();
      if (account == null) {
        throw Exception('Login dengan Google dibatalkan');
      }

      final auth = await account.authentication;
      final idToken = auth.idToken;
      final accessToken = auth.accessToken;

      if (idToken == null) {
        throw Exception('Gagal mendapatkan id_token dari Google');
      }

      final res = await dio.post(
        '/auth/oauth/google/exchange',
        data: {
          'id_token': idToken,
          'access_token': accessToken,
          'device_name': deviceName,
        },
      );

      final data = res.data['data'];
      final token = data['token'] as String?;
      if (token == null || token.isEmpty) {
        throw Exception('Token tidak ditemukan dari server');
      }
      await tokenStorage.writeAccess(token);
    } on DioException catch (e) {
      throw Exception(_extractMessage(e));
    }
  }
  
}
