import 'dart:io';
import 'package:dio/dio.dart';
import 'package:movato/security/token_storage.dart';

Dio buildDio(String baseUrl, TokenStorage tokenStorage) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Accept': 'application/json'},
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await tokenStorage.readAccess();
        if (token != null && token.isNotEmpty) {
          options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (err, handler) {
        
        handler.next(err);
      },
    ),
  );

  // optional: add logging
  // dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  return dio;
}
