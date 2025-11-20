import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:movato/security/token_storage.dart';

import '../core/network/dio_client.dart';
import '../../features/auth/data/auth_repository.dart';

final baseUrlProvider = Provider<String>((_) => 'https://eduapp-api-master-xgvx7r.laravel.cloud/api/v1');

final tokenStorageProvider = Provider<TokenStorage>((_) => TokenStorage());

final dioProvider = Provider<Dio>((ref) {
  return buildDio(ref.watch(baseUrlProvider), ref.watch(tokenStorageProvider));
});

final authRepoProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.watch(dioProvider),
    ref.watch(tokenStorageProvider),
  );
});
