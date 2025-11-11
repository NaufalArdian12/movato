import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:movato/src/core/constants/gaps.dart';
import 'package:movato/src/core/constants/insets.dart';
import 'package:movato/src/core/theme/app_colors.dart';
import 'package:movato/src/core/theme/app_text_styles.dart';
import 'package:movato/src/core/utils/validators.dart';
import 'package:movato/src/core/widgets/app_button.dart';
import 'package:movato/src/core/widgets/app_text_field.dart';
import 'package:movato/src/core/widgets/labeled_field.dart';
import 'package:movato/src/core/widgets/password_field.dart';

import 'package:movato/features/auth/services/auth_service.dart';
import 'sign_up_start_page.dart'; // 🔹 halaman awal Sign Up dengan tombol Google

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailC = TextEditingController();
  final _passC = TextEditingController();

  final _authService = AuthService();

  bool _busy = false;

  @override
  void dispose() {
    _emailC.dispose();
    _passC.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _busy = true);
    try {
      await _authService.login(
        email: _emailC.text.trim(),
        password: _passC.text.trim(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login success')),
      );

      // TODO: arahkan ke dashboard/home setelah login sukses
      // Navigator.pushReplacement(context,
      //   MaterialPageRoute(builder: (_) => const HomePage()));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (_, c) => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: Insets.x4),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: c.maxHeight - Insets.x12),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Insets.x12 * 2),
                    Center(
                      child: SvgPicture.asset(
                        'assets/images/logo.svg',
                        width: 120,
                        height: 120,
                      ),
                    ),
                    Gaps.v32,
                    Text('Log In', style: AppTextStyles.h1),
                    Gaps.v12,
                    Text('Access your account.', style: AppTextStyles.subtitle),
                    Gaps.v24,

                    // ────────────── FORM ──────────────
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabeledField(
                            label: 'Email',
                            child: AppTextField(
                              controller: _emailC,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: const Icon(Icons.mail_outlined, size: 20),
                              validator: Validators.email,
                            ),
                          ),
                          const SizedBox(height: 16),
                          LabeledField(
                            label: 'Password',
                            child: PasswordField(
                              controller: _passC,
                              validator: Validators.password,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '*Minimum 8 characters long',
                            style: AppTextStyles.hint.copyWith(fontSize: 14),
                          ),
                          const SizedBox(height: 24),
                          AppButton(
                            text: 'Log In',
                            isBusy: _busy,
                            onPressed: _onLogin,
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // ────────────── FOOTER LINK ──────────────
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: Insets.x10),
                        child: RichText(
                          text: TextSpan(
                            style: AppTextStyles.subtitle.copyWith(color: Colors.black87),
                            children: [
                              const TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: 'Sign Up',
                                style: AppTextStyles.link.copyWith(color: AppColors.text),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
