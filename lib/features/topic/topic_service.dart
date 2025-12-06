import 'package:dio/dio.dart';
import 'models/topic.dart';

class TopicService {
  final Dio dio;
  TopicService(this.dio);

  Future<List<Topic>> getTopics({int? gradeLevelId}) async {
    final res = await dio.get(
      '/topics',
      queryParameters: gradeLevelId != null
          ? {'grade_level_id': gradeLevelId}
          : null,
    );

    final List<dynamic> rawList =
        (res.data['data'] ?? res.data) as List<dynamic>;
    return rawList
        .map((e) => Topic.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Topic> getTopic(int id) async {
    final res = await dio.get('/topics/$id');

    final Map<String, dynamic> raw =
        (res.data['data'] ?? res.data) as Map<String, dynamic>;
    return Topic.fromJson(raw);
  }
}
