import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movato/features/auth/presentation/pages/sign_up_start_page.dart';
import 'package:movato/features/dashboard/dashboard_page.dart';
import 'package:movato/src/core/widgets/auth_scaffold.dart';
import 'package:movato/src/core/widgets/app_text_field.dart';
import 'package:movato/src/core/widgets/google_button.dart';
import 'package:movato/src/core/widgets/labeled_field.dart';
import 'package:movato/src/core/widgets/password_field.dart';
import 'package:movato/src/core/widgets/form_error_text.dart';
import 'package:movato/src/core/widgets/app_button.dart';
import 'package:movato/src/core/theme/app_text_styles.dart';
import 'package:movato/src/core/theme/app_colors.dart';
import 'package:movato/src/core/constants/gaps.dart';
import 'package:movato/src/core/utils/validators.dart';
import 'package:movato/features/auth/services/auth_service.dart';
import 'package:movato/features/auth/state/auth_notifier.dart';
import 'package:movato/features/auth/state/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailC = TextEditingController();
  final _passC = TextEditingController();
  final _auth = AuthService();

  bool _busy = false;
  final bool _googleBusy = false;
  String? _emailError;
  String? _passError;

  @override
  void dispose() {
    _emailC.dispose();
    _passC.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    final emailErr = Validators.email(_emailC.text.trim());
    final passErr = Validators.password(_passC.text);

    setState(() {
      _emailError = emailErr;
      _passError = passErr;
    });

    if (emailErr != null || passErr != null) return;

    // capture navigator & messenger sebelum await
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    setState(() => _busy = true);
    try {
      await _auth.login(
        email: _emailC.text.trim(),
        password: _passC.text.trim(),
      );
      if (!mounted) return;

      messenger.showSnackBar(const SnackBar(content: Text('Login success')));
      navigator.pushReplacement(
        MaterialPageRoute(builder: (_) => const DashboardPage()),
      );
    } catch (e) {
      if (!mounted) return;
      final msg = e.toString().replaceFirst('Exception: ', '');
      messenger.showSnackBar(SnackBar(content: Text(msg)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Log In',
      subtitle: 'Access your account.',
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabeledField(
            label: 'Email',
            child: AppTextField(
              controller: _emailC,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.mail_outlined, size: 20),
              hintText: 'Enter your email address',
              onChanged: (_) => setState(
                () => _emailError = Validators.email(_emailC.text.trim()),
              ),
            ),
          ),
          if (_emailError != null) Gaps.v8,
          if (_emailError != null) FormErrorText(_emailError!),

          Gaps.v16,

          LabeledField(
            label: 'Password',
            child: PasswordField(
              controller: _passC,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock_outline, size: 20),
                hintText: 'Enter your password',
              ),
              onFieldSubmitted: (_) => _onLogin(),
              onChanged: (_) =>
                  setState(() => _passError = Validators.password(_passC.text)),
            ),
          ),
          if (_passError != null) Gaps.v8,
          if (_passError != null) FormErrorText(_passError!),

          Gaps.v8,
          Text(
            '*Minimum 8 characters long',
            style: AppTextStyles.hint.copyWith(fontSize: 14),
          ),
        ],
      ),
      primaryButton: AppButton(
        text: 'Log In',
        isBusy: _busy,
        onPressed: _onLogin,
      ),
      footer: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Gaps.v16,
          Consumer(
            builder: (context, ref, _) {
              final s = ref.watch(authNotifierProvider);
              final isLoading = (s is Authenticating);

              Future<void> onGoogle() async {
                final navigator = Navigator.of(context);
                final messenger = ScaffoldMessenger.of(context);

                await ref
                    .read(authNotifierProvider.notifier)
                    .signInWithGoogle();

                final current = ref.read(authNotifierProvider);
                if (!context.mounted) return;

                if (current is Authenticated) {
                  messenger.showSnackBar(
                    const SnackBar(content: Text('Login with Google success')),
                  );
                  navigator.pushReplacement(
                    MaterialPageRoute(builder: (_) => const DashboardPage()),
                  );
                } else if (current is AuthError) {
                  messenger.showSnackBar(
                    SnackBar(content: Text(current.message)),
                  );
                }
              }

              return GoogleButton(
                text: 'Continue with Google',
                isBusy: isLoading,
                onPressed: onGoogle,
              );
            },
          ),
          Gaps.v16,
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: AppTextStyles.subtitle.copyWith(color: Colors.black87),
              children: [
                const TextSpan(text: "Don't have an account? "),
                TextSpan(
                  text: 'Sign Up',
                  style: AppTextStyles.link.copyWith(color: AppColors.text),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SignUpStartPage(),
                        ),
                      );
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
