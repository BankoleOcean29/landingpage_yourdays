import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.bgDeep,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.terracotta,
      secondary: AppColors.amber,
      surface: AppColors.bgCard,
    ),
    useMaterial3: true,
  );
}
