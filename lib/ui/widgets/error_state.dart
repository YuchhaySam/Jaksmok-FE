import 'package:flutter/material.dart';
import 'package:jaksmok_fe/core/extensions/theme_extension.dart';

class ErrorState extends StatelessWidget {
  final String error;
  final VoidCallback onPressed;
  const ErrorState({super.key, required this.error, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 60, color: context.error),
              const SizedBox(height: 16),
              Text(error, style: TextStyle(color: context.error)),
              TextButton(onPressed: onPressed, child: const Text('Retry')),
            ],
          ),
        ),
      ),
    );
  }
}
