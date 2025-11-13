import 'package:dio/dio.dart';
import 'package:movato/security/token_storage.dart';
import 'package:movato/features/user/user_model.dart';

class AuthRepository {
  final Dio _dio;
  final TokenStorage _storage;
  AuthRepository(this._dio, this._storage);

  Future<UserModel> exchangeGoogleIdToken(String idToken) async {
    final res = await _dio.post(
      '/auth/oauth/google/exchange',
      data: {'id_token': idToken},
    );
    final data = res.data['data'];
    await _storage.save(data['access_token'], data['refresh_token']);
    return UserModel.fromJson(data['user']);
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
