class TopicModel {
  final int id;
  final String title;
  final String description;
  final int orderIndex;
  final double progress;
  final String image;

  TopicModel({
    required this.id,
    required this.title,
    required this.description,
    required this.orderIndex,
    required this.progress,
    required this.image,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      orderIndex: json['order_index'] ?? 0,
      progress: json['progress']?.toDouble() ?? 0.0,
      image: json['image'] ?? 'assets/images/class1.png',
    );
  }
}
