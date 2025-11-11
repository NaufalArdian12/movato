class UserModel {
  final String id;
  final String email;
  final String username;
  final String fullName;
  final String? education;
  final String? photoUrl;
  final bool isEmailVerified;

  const UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.fullName,
    this.education,
    this.photoUrl,
    this.isEmailVerified = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      fullName: json['fullName'] ?? '',
      education: json['education'],
      photoUrl: json['photoUrl'],
      isEmailVerified: json['isEmailVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'fullName': fullName,
      'education': education,
      'photoUrl': photoUrl,
      'isEmailVerified': isEmailVerified,
    };
  }
}
