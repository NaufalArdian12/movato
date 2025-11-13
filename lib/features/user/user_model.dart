class UserModel {
  final int id;
  final String name;
  final String email;
  final String? avatar;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });
  factory UserModel.fromJson(Map<String, dynamic> j) => UserModel(
    id: j['id'],
    name: j['name'],
    email: j['email'],
    avatar: j['avatar'],
  );
}
