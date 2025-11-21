import 'package:dio/dio.dart';
import 'package:movato/security/token_storage.dart';
import 'package:movato/src/core/network/dio_client.dart';

Dio buildDio(String baseUrl, TokenStorage storage) {
  final authless = Dio(BaseOptions(baseUrl: baseUrl));
  final dio = Dio(BaseOptions(baseUrl: baseUrl));

  dio.interceptors.add(AuthInterceptor(storage, authless));

  return dio;
}
