import 'package:flutter/material.dart';
import 'package:jaksmok_fe/core/themes/theme_extension.dart';

extension SnackbarExtension on BuildContext {
  void showSnackBar(String message, isError) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontSize: 16)),
        backgroundColor: isError ? error : secondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        margin: const EdgeInsets.all(20),
      ),
    );
  }
}
