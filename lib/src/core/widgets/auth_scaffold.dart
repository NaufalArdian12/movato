import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/insets.dart';
import '../constants/gaps.dart';
import '../theme/app_text_styles.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.form,
    required this.primaryButton,
    required this.footer,
    this.logoPath = 'assets/images/logo.svg',
  });

  final String title;
  final String subtitle;
  final Widget form;
  final Widget primaryButton;
  final Widget footer;
  final String logoPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (_, c) {
            final minHeight = (c.maxHeight - Insets.x12).clamp(
              0.0,
              double.infinity,
            );

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: Insets.x4),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: minHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Insets.x12 * 2),
                      Center(
                        child: SvgPicture.asset(
                          logoPath,
                          width: 120,
                          height: 120,
                        ),
                      ),
                      Gaps.v32,
                      Text(title, style: AppTextStyles.h1),
                      Gaps.v12,
                      Text(subtitle, style: AppTextStyles.subtitle),
                      Gaps.v24,

                      form,
                      Gaps.v24,
                      primaryButton,

                      const Spacer(),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: Insets.x2,
                          ),
                          child: footer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
