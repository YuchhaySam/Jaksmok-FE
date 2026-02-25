import 'package:flutter/material.dart';

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
    final theme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: theme.primary),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: theme.onPrimary,
                  strokeWidth: 3,
                ),
              )
            : Text(
                buttonText,
                style: TextStyle(
                  color: theme.onPrimary,
                  fontSize: fontSize ?? 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
      ),
    );
  }
}
