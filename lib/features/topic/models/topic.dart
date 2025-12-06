class Topic {
  final int id;
  final String title;
  final String? description;
  final int? gradeLevelId;
  final List<dynamic>? videos; // sesuaikan structure jika mau model lebih kuat
  final List<dynamic>? quizzes;

  Topic({
    required this.id,
    required this.title,
    this.description,
    this.gradeLevelId,
    this.videos,
    this.quizzes,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'] is int ? json['id'] as int : int.parse(json['id'].toString()),
      title: (json['title'] ?? json['name'] ?? '').toString(),
      description: (json['description'] ?? json['desc'])?.toString(),
      gradeLevelId: json['grade_level_id'] != null
          ? (json['grade_level_id'] is int ? json['grade_level_id'] as int : int.parse(json['grade_level_id'].toString()))
          : null,
      videos: json['videos'] is List ? List<dynamic>.from(json['videos']) : null,
      quizzes: json['quizzes'] is List ? List<dynamic>.from(json['quizzes']) : null,
    );
  }
}
