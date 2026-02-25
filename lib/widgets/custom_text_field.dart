import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isObscureText;
  final String hintText;
  final String? error;
  final VoidCallback? showPassword;
  final TextInputType? keyboard;
  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.isObscureText,
    required this.hintText,
    this.error,
    this.showPassword,
    this.keyboard,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: controller,
        obscureText: isObscureText,
        keyboardType: keyboard ?? TextInputType.text,
        decoration: InputDecoration(
          errorText: error,
          hintText: hintText,
          labelText: label,
          helperText: error == null ? '' : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              width: 1,
              color: theme.onSurface.withValues(alpha: 0.3),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1, color: theme.onSurface),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1, color: theme.primary),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 2, color: theme.primary),
          ),
          suffixIcon: showPassword != null
              ? IconButton(
                  onPressed: showPassword,
                  icon: Icon(
                    isObscureText ? Icons.visibility : Icons.visibility_off,
                    size: 20,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
