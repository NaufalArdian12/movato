import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../data/auth_repository.dart';
import '../../user/user_model.dart';
import 'auth_state.dart';
import '../../../src/di/providers.dart';

final googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

/// v3: NotifierProvider
final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository _repo = ref.read(authRepoProvider);

  @override
  AuthState build() {
    // initial state
    return const Unauthenticated();
  }

  Future<void> signInWithGoogle() async {
    state = const Authenticating();
    try {
      final acc = await googleSignIn.signIn();
      final auth = await acc?.authentication;
      final idToken = auth?.idToken;
      if (idToken == null) throw Exception('Google sign-in failed');

      final UserModel user = await _repo.exchangeGoogleIdToken(idToken);
      state = Authenticated(user);
    } catch (_) {
      state = const AuthError('Login gagal. Coba lagi.');
    }
  }

  Future<void> loadSession() async {
    try {
      final user = await _repo.me();
      state = Authenticated(user);
    } catch (_) {
      state = const Unauthenticated();
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    await googleSignIn.signOut();
    state = const Unauthenticated();
  }
}
