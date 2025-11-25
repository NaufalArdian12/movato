import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:movato/features/auth/data/auth_repository.dart';
import 'package:movato/features/course/data/course_repository.dart';
import 'package:movato/features/course/data/topic_model.dart';
import 'package:movato/security/token_storage.dart';
import 'package:movato/src/core/network/dio_builder.dart';

final baseUrlProvider = Provider<String>(
  (_) => 'https://eduapp-api-master-xgvx7r.laravel.cloud/api/v1',
);

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
final courseRepoProvider = Provider<CourseRepository>((ref) {
  return CourseRepository(
    ref.watch(dioProvider),
    ref.watch(tokenStorageProvider),
  );
});
final topicsProvider = FutureProvider.autoDispose<List<TopicModel>>((
  ref,
) async {
  final repo = ref.watch(courseRepoProvider);
  return repo.getTopics();
});
