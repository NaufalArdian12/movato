// lib/src/providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:movato/features/auth/data/auth_repository.dart';
import 'package:movato/features/auth/services/auth_service.dart';
import 'package:movato/features/user/user_service.dart';
import 'package:movato/security/token_storage.dart';
import 'package:movato/src/core/network/dio_builder.dart';

final baseUrlProvider = Provider<String>(
  (_) => 'https://eduapp-api-master-xgvx7r.laravel.cloud/api/v1',
);

final tokenStorageProvider = Provider<TokenStorage>((_) => TokenStorage());

final dioProvider = Provider<Dio>((ref) {
  final baseUrl = ref.watch(baseUrlProvider);
  final tokenStorage = ref.watch(tokenStorageProvider);
  return buildDio(baseUrl, tokenStorage);
});

final authServiceProvider = Provider<AuthService>((ref) {
  final dio = ref.watch(dioProvider);
  final tokenStorage = ref.watch(tokenStorageProvider);
  return AuthService(dio: dio, tokenStorage: tokenStorage);
});

final userServiceProvider = Provider<UserService>((ref) {
  final dio = ref.watch(dioProvider);
  final storage = ref.watch(tokenStorageProvider);
  return UserService(dio, storage);
});

final authRepoProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.watch(dioProvider),
    ref.watch(tokenStorageProvider),
  );
});
