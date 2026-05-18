import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static double _fluid(double width, double min, double max) {
    return (min + (max - min) * ((width - 320) / (1280 - 320))).clamp(min, max);
  }

  static TextStyle heroHeadline(double width) => GoogleFonts.lora(
    fontSize: _fluid(width, 28, 58),
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.03 * _fluid(width, 28, 58),
    height: 1.15,
  );

  static TextStyle sectionTitle(double width) => GoogleFonts.lora(
    fontSize: _fluid(width, 22, 38),
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.02 * _fluid(width, 22, 38),
  );

  static TextStyle sectionSubtitle(double width) => GoogleFonts.lora(
    fontSize: _fluid(width, 16, 22),
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static TextStyle body(double width) => GoogleFonts.nunito(
    fontSize: _fluid(width, 14, 17),
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.7,
  );

  static TextStyle sectionLabel() => GoogleFonts.nunito(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.terracotta,
    letterSpacing: 0.15 * 12,
  );

  static TextStyle small() => GoogleFonts.nunito(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
  );

  static TextStyle navBrand() => GoogleFonts.lora(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle buttonLabel() => GoogleFonts.nunito(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
  );
}
