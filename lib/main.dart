import 'package:flutter/material.dart';
import 'package:jaksmok_fe/notifiers/global_notifier.dart';
import 'package:jaksmok_fe/screens/home_screen.dart';
import 'package:jaksmok_fe/screens/login_screen.dart';
import 'package:jaksmok_fe/services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        //Define the colorScheme so we can reuse it everywhere.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF67280),
          primary: const Color(0xFFF67280),
          onPrimary: const Color(0xFFFFFFFF),
          surfaceContainerLowest: const Color(0xFFFCF9F6),
          surfaceContainerLow: const Color(0xFFF5F0EA),
          surfaceContainerHigh: const Color(0xFFFFFFFF),
          onSurface: const Color(0xFF2D2D2D),
          secondary: const Color(0xFF88AB8E),
          error: const Color(0xFFFA003F),
        ),
      ),

      //Check for authNotifier to skip the login screen if it's true
      home: ApiService.authNotifier.value
          ? const HomeScreen()
          : const LoginScreen(),
    );
  }
}
