import 'package:flutter/material.dart';
import 'package:jaksmok_fe/core/themes/theme_extension.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final bool isLoading;
  final double? height;
  final double? fontSize;
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.buttonText,
    this.height,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: context.elevatedButtonTheme.style,
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: context.onPrimary,
                  strokeWidth: 3,
                ),
              )
            : Text(
                buttonText,
                style: TextStyle(
                  color: context.onPrimary,
                  fontSize: fontSize ?? 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
      ),
    );
  }
}
