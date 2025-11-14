import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movato/features/auth/data/auth_repository.dart';
import 'package:movato/features/auth/state/auth_state.dart';
import 'package:movato/features/user/user_model.dart';
import 'package:movato/src/di/providers.dart';

final googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile'],
  serverClientId:
      '904572986595-uukbc6v689mkuvi0rnh6k620eon8pm81.apps.googleusercontent.com',
);

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository _repo = ref.read(authRepoProvider);

  @override
  AuthState build() {
    return const Unauthenticated();
  }

  Future<void> signInWithGoogle() async {
    state = const Authenticating();
    try {
      try {
        await googleSignIn.disconnect();
      } catch (e) {
        debugPrint('googleSignIn.disconnect error (ignored): $e');
      }

      final acc = await googleSignIn.signIn();
      debugPrint('GoogleSignIn account: ${acc?.email}');

      if (acc == null) {
        state = const AuthError('Login dengan Google dibatalkan');
        return;
      }

      final auth = await acc.authentication;
      debugPrint('idToken (first 30): ${auth.idToken?.substring(0, 30)}');

      if (auth.idToken == null) {
        state = const AuthError('Gagal mendapatkan token dari Google');
        return;
      }

      final UserModel user = await _repo.exchangeGoogleIdToken(auth.idToken!);

      state = Authenticated(user);
    } catch (e, st) {
      debugPrint('Sign in error (full): $e\n$st');
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
