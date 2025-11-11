import 'dart:math';
import 'package:movato/features/auth/models/user_model.dart';

class AuthService {
  AuthService._internal();
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  Future<UserModel> signUp({
    required String email,
    required String username,
    required String password,
    required String fullName,
    String? education,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    if (!email.contains('@')) {
      throw Exception('Invalid email');
    }
    if (password.length < 8) {
      throw Exception('Password too short');
    }

    final user = UserModel(
      id: _generateId(),
      email: email,
      username: username,
      fullName: fullName,
      education: education,
      isEmailVerified: false,
    );

    _currentUser = user;
    return user;
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    if (!email.contains('@')) {
      throw Exception('Invalid email');
    }
    if (password.length < 8) {
      throw Exception('Wrong email or password');
    }

    _currentUser ??= UserModel(
      id: _generateId(),
      email: email,
      username: email.split('@').first,
      fullName: 'User $email',
      isEmailVerified: true,
    );

    return _currentUser!;
  }

  Future<void> sendVerificationEmail(String email) async {
    await Future.delayed(const Duration(milliseconds: 800));
    // di real case: panggil backend/Firebase
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _currentUser = null;
  }

  String _generateId() {
    final rand = Random();
    return List.generate(12, (_) => rand.nextInt(10)).join();
  }
}
