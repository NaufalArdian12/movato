import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'verify_email_page.dart';
import 'sign_up_page.dart';

import 'package:movato/src/core/constants/gaps.dart';
import 'package:movato/src/core/constants/insets.dart';
import 'package:movato/src/core/theme/app_text_styles.dart';
import 'package:movato/src/core/theme/app_colors.dart';
import 'package:movato/src/core/utils/validators.dart';

class SignUpStartPage extends StatefulWidget {
  const SignUpStartPage({super.key});

  @override
  State<SignUpStartPage> createState() => _SignUpStartPageState();
}

class _SignUpStartPageState extends State<SignUpStartPage> {
  final _emailC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _busy = false;

  @override
  void dispose() {
    _emailC.dispose();
    super.dispose();
  }

  Future<void> _onContinue() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _busy = true);
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() => _busy = false);

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

              // Email input
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _emailC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email address',
                    prefixIcon: Icon(Icons.mail_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                  ),
                  validator: Validators.email,
                ),
              ),
              Gaps.v16,

              // Continue button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _busy ? null : _onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: _busy
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Continue',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),

              const Spacer(),

              // Tombol Sign Up bawah → buka form profile
            Center(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SignUpPage(),
                    ),
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
                        const TextSpan(
                          text: "Don't have an account? ",
                        ),
                        TextSpan(
                          text: 'Sign Up',
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
