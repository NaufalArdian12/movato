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
import 'package:movato/src/core/widgets/form_error_text.dart';

import 'package:movato/features/auth/services/auth_service.dart';
import 'sign_up_start_page.dart';

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
  String? _emailError;
  String? _passError;

  @override
  void dispose() {
    _emailC.dispose();
    _passC.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    // validasi manual agar error bisa ditempatkan custom (rata kiri dengan tombol)
    final emailErr = Validators.email(_emailC.text.trim());
    final passErr = Validators.password(_passC.text);

    setState(() {
      _emailError = emailErr;
      _passError = passErr;
    });

    if (emailErr != null || passErr != null) return;

    setState(() => _busy = true);
    try {
      await _auth.login(email: _emailC.text.trim(), password: _passC.text);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Login success')));

      // ✅ Arahkan ke Dashboard setelah login sukses
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardPage()),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Login success')));
      // TODO: Navigator.pushReplacement(...);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e'.replaceFirst('Exception: ', ''))),
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
                              prefixIcon: const Icon(
                                Icons.mail_outlined,
                                size: 20,
                              ),
                              validator: Validators.email,
                    // ===== FORM =====
                    LabeledField(
                      label: 'Email',
                      child: AppTextField(
                        controller: _emailC,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.mail_outlined, size: 20),
                        hintText: 'Enter your email address',
                        onChanged: (_) {
                          setState(
                            () => _emailError = Validators.email(
                              _emailC.text.trim(),
                            ),
                          );
                        },
                      ),
                    ),
                    if (_emailError != null) const SizedBox(height: 6),
                    if (_emailError != null) FormErrorText(_emailError!),

                    const SizedBox(height: 16),

                    LabeledField(
                      label: 'Password',
                      child: PasswordField(
                        controller: _passC,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline, size: 20),
                          hintText: 'Enter your password',
                        ),
                        onFieldSubmitted: (_) => _onLogin(),
                      ),
                    ),
                    if (_passError != null) const SizedBox(height: 6),
                    if (_passError != null) FormErrorText(_passError!),

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

                    const Spacer(),

                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Insets.x10,
                        ),
                        child: RichText(
                          text: TextSpan(
                            style: AppTextStyles.subtitle.copyWith(
                              color: Colors.black87,
                            ),
                            children: [
                              const TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: 'Sign Up',
                                style: AppTextStyles.link.copyWith(
                                  color: AppColors.text,
                                ),
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
