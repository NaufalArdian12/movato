import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movato/src/core/widgets/labeled_field.dart';
import '../../../../src/core/constants/gaps.dart';
import '../../../../src/core/constants/insets.dart';
import '../../../../src/core/theme/app_colors.dart';
import '../../../../src/core/theme/app_text_styles.dart';
import '../../../../src/core/utils/validators.dart';
import '../../../../src/core/widgets/app_button.dart';
import '../../../../src/core/widgets/app_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../src/core/widgets/password_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailC = TextEditingController();
  final _passC = TextEditingController();

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
    // TODO: panggil auth usecase / API
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() => _busy = false);
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
                            ),
                          ),
                          const SizedBox(height: 16), // ← antar form 16

                          LabeledField(
                            label: 'Password',
                            child: PasswordField(
                              controller: _passC,
                              validator: Validators.password,
                            ),
                          ),

                          const SizedBox(
                            height: 8,
                          ), // jarak kecil sebelum helper text
                          Text(
                            '*Minimum 8 characters long',
                            style: AppTextStyles.hint.copyWith(fontSize: 14),
                          ),
                          const SizedBox(height: 24),
                          AppButton(
                            text: 'Login',
                            isBusy: _busy,
                            onPressed: _onLogin,
                          ),
                        ],
                      ),
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
                              const TextSpan(text: "don't have an account? "),
                              TextSpan(
                                text: 'sign up',
                                style: AppTextStyles.link.copyWith(
                                  color: AppColors.text,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // TODO: push to signup page
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
