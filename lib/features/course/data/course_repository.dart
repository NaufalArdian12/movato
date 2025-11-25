import 'package:dio/dio.dart';
import 'topic_model.dart';
import 'package:movato/security/token_storage.dart';

class CourseRepository {
  final Dio dio;
  final TokenStorage tokenStorage;

  CourseRepository(this.dio, this.tokenStorage);
  //topic model
  Future<List<TopicModel>> getTopics() async {
    final response = await dio.get('/topics');
    final data = response.data['data'] as List;
    return data.map((e) => TopicModel.fromJson(e)).toList();
  }
}
