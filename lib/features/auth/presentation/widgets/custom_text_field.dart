import 'package:flutter/material.dart';
import 'package:jaksmok_fe/core/themes/theme_extension.dart';

//Define a custom text field widget, in the purpose of
//reusing it where a text field is needed, plus we also
//achieved a consistence design
class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isObscureText;
  final String hintText;
  final VoidCallback? showPassword;
  final TextInputType? keyboard;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.isObscureText,
    required this.hintText,
    this.showPassword,
    this.keyboard,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText,
        keyboardType: keyboard ?? TextInputType.text,
        validator: validator,
        style: TextStyle(color: context.onSurface),
        decoration: InputDecoration(
          hintText: hintText,
          labelText: label,
          helperText: '',

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
