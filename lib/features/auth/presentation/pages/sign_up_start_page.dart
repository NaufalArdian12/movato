import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movato/src/core/widgets/auth_scaffold.dart';
import 'package:movato/src/core/theme/app_text_styles.dart';
import 'package:movato/src/core/theme/app_colors.dart';
import 'package:movato/src/core/widgets/google_button.dart';

import 'login_page.dart';
import 'package:movato/features/auth/state/auth_notifier.dart';
import 'package:movato/features/auth/state/auth_state.dart';
import 'package:movato/features/dashboard/dashboard_page.dart';

class SignUpStartPage extends StatefulWidget {
  const SignUpStartPage({super.key});

  @override
  State<SignUpStartPage> createState() => _SignUpStartPageState();
}

class _SignUpStartPageState extends State<SignUpStartPage> {
  bool googleBusy = false;

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Sign Up',
      subtitle: 'Join us and get started',

      form: const SizedBox.shrink(),

      primaryButton: Consumer(
        builder: (context, ref, _) {
          final s = ref.watch(authNotifierProvider);
          final isLoading = (s is Authenticating);

          Future<void> onGoogle() async {
            final navigator = Navigator.of(context);
            final messenger = ScaffoldMessenger.of(context);

            await ref.read(authNotifierProvider.notifier).signInWithGoogle();

            final current = ref.read(authNotifierProvider);
            if (!context.mounted) return;

            if (current is Authenticated) {
              navigator.pushReplacement(
                MaterialPageRoute(builder: (_) => const DashboardPage()),
              );
            } else if (current is AuthError) {
              messenger.showSnackBar(SnackBar(content: Text(current.message)));
            }
          }

          return GoogleButton(
            text: 'Continue with Google',
            isBusy: isLoading,
            onPressed: onGoogle,
            // filled: false, // set true kalau mau versi solid
          );
        },
      ),
      footer: RichText(
        text: TextSpan(
          style: AppTextStyles.subtitle.copyWith(color: Colors.black87),
          children: [
            const TextSpan(text: 'Already have an account? '),
            TextSpan(
              text: 'Login',
              style: AppTextStyles.link.copyWith(color: AppColors.text),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
