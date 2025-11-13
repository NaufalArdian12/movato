import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  static final ApiClient _i = ApiClient._();
  factory ApiClient() => _i;
  ApiClient._();

  // GANTI sesuai server kamu
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  // iOS simulator → http://localhost:8000/api
  // Device fisik → IP LAN server kamu

  final _storage = const FlutterSecureStorage();
  late final Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
    headers: {'Accept': 'application/json'},
  ))
    ..interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'auth_token');
        if (token != null && token.isNotEmpty) {
          options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (e, handler) {
        // bisa tambah auto-logout kalau 401 global
        handler.next(e);
      },
    ));

  Future<void> saveToken(String token) => _storage.write(key: 'auth_token', value: token);
  Future<void> clearToken() => _storage.delete(key: 'auth_token');
  Future<String?> get token async => _storage.read(key: 'auth_token');
}
