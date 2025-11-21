import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movato/security/token_storage.dart';
import 'package:movato/features/user/user_model.dart';

class AuthRepository {
  final Dio _dio;
  final TokenStorage _storage;
  AuthRepository(this._dio, this._storage);

  Future<UserModel> exchangeGoogleIdToken(String idToken) async {
    final fullUrl = '${_dio.options.baseUrl}/auth/oauth/google/exchange';
    debugPrint('👉 [AuthRepository] Hitting URL: $fullUrl');

    final res = await _dio.post(
      '/auth/oauth/google/exchange',
      data: {'id_token': idToken},
    );

    final data = res.data['data'];
    final userJson = data['user'];
    final tokens = data['tokens'];

    if (tokens != null) {
      final access = tokens['access'] as String?;
      final refresh = tokens['refresh'] as String?;
      if (access != null && refresh != null) {
        await _storage.save(access, refresh);
      }
    }

    return UserModel.fromJson(userJson);
  }

  Future<void> linkGoogleIdToken(String idToken) async {
    await _dio.post('/auth/oauth/google/link', data: {'id_token': idToken});
  }

  Future<void> logout() async {
    try {
      await _dio.post('/auth/logout');
    } catch (_) {}
    await _storage.clear();
    // optional: update provider state, mis. ref.read(authNotifierProvider.notifier).logout();
  }

  Future<UserModel> me() async {
    final res = await _dio.get('/me');
    return UserModel.fromJson(res.data);
  }
}
