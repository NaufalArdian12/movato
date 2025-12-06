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

    Response? res;
    try {
      res = await _dio.post(
        "/auth/oauth/google/exchange",
        data: {"id_token": idToken},
      );

      debugPrint(
        "👉 [AuthRepository] exchange response: ${res.statusCode} ${res.data}",
      );
    } on DioException catch (e) {
      debugPrint(
        "Exchange failed: ${e.response?.statusCode} ${e.response?.data}",
      );
      rethrow;
    } catch (e) {
      debugPrint("Unexpected error during exchange: $e");
      rethrow;
    }

    final body = res.data;
    if (body == null) {
      throw Exception("Empty response from exchange endpoint");
    }

    final data = (body is Map && body['data'] != null) ? body['data'] : body;
    final userJson = (data is Map) ? (data['user'] ?? data['user']) : null;

    final resolvedUserJson = userJson ?? (data is Map ? data : null);

    if (resolvedUserJson == null) {
      debugPrint("Raw response body: $body");
      throw Exception("Response does not contain user data");
    }

    String? access;
    String? refresh;

    if (data is Map) {
      final tokens = data['tokens'];
      if (tokens is Map) {
        access = tokens['access']?.toString();
        refresh = tokens['refresh']?.toString();
      }

      access ??= data['access_token']?.toString();
      refresh ??= data['refresh_token']?.toString();

      access ??= body['access_token']?.toString();
      refresh ??= body['refresh_token']?.toString();

      if (access == null && tokens is Map) {
        access =
            tokens['access_token']?.toString() ?? tokens['token']?.toString();
        refresh = refresh ?? tokens['refresh_token']?.toString();
      }
    }

    if (access != null && refresh != null) {
      await _storage.save(access, refresh);
    } else if (access != null) {
      
      await _storage.save(access, refresh ?? '');
    } else {
      debugPrint("No tokens found in exchange response.");
    }

    final userMap = (resolvedUserJson is Map)
        ? Map<String, dynamic>.from(resolvedUserJson)
        : null;
    if (userMap == null) {
      throw Exception("User data has unexpected format: $resolvedUserJson");
    }

    return UserModel.fromJson(userMap);
  }

  Future<void> linkGoogleIdToken(String idToken) async {
    await _dio.post('/auth/oauth/google/link', data: {'id_token': idToken});
  }

  Future<void> logout() async {
    try {
      await _dio.post('/auth/logout');
    } catch (_) {}
    await _storage.clear();
  }

  Future<UserModel> me() async {
    final res = await _dio.get('/me');
    return UserModel.fromJson(res.data);
  }
}
