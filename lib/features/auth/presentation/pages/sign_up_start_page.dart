import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movato/features/auth/presentation/pages/login_page.dart';
import 'package:movato/src/core/widgets/app_button.dart';

import 'verify_email_page.dart';

import 'package:movato/src/core/constants/gaps.dart';
import 'package:movato/src/core/constants/insets.dart';
import 'package:movato/src/core/theme/app_text_styles.dart';
import 'package:movato/src/core/theme/app_colors.dart';
import 'package:movato/src/core/utils/validators.dart';
import 'package:movato/src/core/widgets/labeled_field.dart';
import 'package:movato/src/core/widgets/app_text_field.dart';

class SignUpStartPage extends StatefulWidget {
  const SignUpStartPage({super.key});

  @override
  State<SignUpStartPage> createState() => _SignUpStartPageState();
}

class _SignUpStartPageState extends State<SignUpStartPage> {
  final _emailC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailC.dispose();
    super.dispose();
  }

  Future<void> _onContinue() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VerifyEmailPage(email: _emailC.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.x4),
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
              Text('Sign Up', style: AppTextStyles.h1),
              Gaps.v8,
              Text('Join us and get started', style: AppTextStyles.subtitle),
              Gaps.v32,

              Form(
                key: _formKey,
                child: LabeledField(
                  label: 'Email',
                  child: AppTextField(
                    controller: _emailC,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Enter your email address',
                    prefixIcon: const Icon(Icons.mail_outline, size: 20),
                    validator: Validators.email,
                  ),
                ),
              ),

              Gaps.v16,

              AppButton(text: 'Continue', onPressed: _onContinue),

              const Spacer(),

              Center(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: Insets.x8),
                      child: Text.rich(
                        TextSpan(
                          style: AppTextStyles.subtitle.copyWith(
                            color: Colors.black87,
                          ),
                          children: [
                            const TextSpan(text: "Already have an account? "),
                            TextSpan(
                              text: 'Sign In',
                              style: AppTextStyles.link.copyWith(
                                color: AppColors.text,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
