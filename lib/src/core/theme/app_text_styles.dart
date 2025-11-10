import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const _font = 'SFProDisplay';

  static TextStyle h1 = const TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600,
    fontSize: 40,
    height: 48 / 40,
    color: AppColors.text,
    letterSpacing: -0.2,
  );

  static TextStyle subtitle = const TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 24 / 18,
    color: AppColors.textSecondary,
  );

  static TextStyle button = const TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 22 / 18,
    color: Colors.white,
  );

  static TextStyle link = const TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.text,
  );

  static TextStyle formLabel = const TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 18 / 14,
    color: AppColors.text,
  );

  // text di dalam field
  static TextStyle field = const TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 20 / 16,
    color: AppColors.text,
  );

  static TextStyle hint = const TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 20 / 16,
    color: Color(0xFFB0B0B8),
  );
}
