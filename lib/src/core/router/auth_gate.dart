import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/auth/state/auth_notifier.dart';
import '../../../features/auth/state/auth_state.dart';
import '../../../features/dashboard/dashboard_page.dart';
import '../../../features/auth/presentation/pages/login_page.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(authNotifierProvider);

    if (s is Authenticating) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (s is Authenticated) {
      return const DashboardPage();
    }
    return const LoginPage();
  }
}
