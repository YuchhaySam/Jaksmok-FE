import 'package:flutter/material.dart';
import 'package:jaksmok_fe/core/themes/app_color.dart';

class AppTheme {
  static final lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: ColorScheme.light(
      primary: AppColor.primary,
      onPrimary: AppColor.onPrimary,
      surfaceContainerLowest: AppColor.surfaceContainerLowest, // Match these up
      surfaceContainerLow: AppColor.surfaceContainerLow,
      surfaceContainerHigh: AppColor.surfaceContainerHigh,
      onSurface: AppColor.onSurface,
      secondary: AppColor.secondary,
      error: AppColor.error,
    ),
    scaffoldBackgroundColor: AppColor.surfaceContainerLowest,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.surfaceContainerLowest,
    ),

    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColor.onSurface,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: AppColor.onSurface,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primary,
        foregroundColor: AppColor.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          width: 1,
          color: AppColor.onSurface.withValues(alpha: 0.3),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(width: 1, color: AppColor.onSurface),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(width: 1, color: AppColor.primary),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(width: 2, color: AppColor.primary),
      ),
    ),
  );
}
