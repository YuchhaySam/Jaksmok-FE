import 'package:flutter/material.dart';
import 'package:jaksmok_fe/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF67280),
          primary: const Color(0xFFF67280),
          onPrimary: const Color(0xFFFFFFFF),
          surfaceContainerLowest: const Color(0xFFFCF9F6),
          surfaceContainerLow: const Color(0xFFF5F0EA),
          surfaceContainerHigh: const Color(0xFFFFFFFF),
          onSurface: const Color(0xFF2D2D2D),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
