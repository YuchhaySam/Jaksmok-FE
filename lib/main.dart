import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaksmok_fe/data/repositories/auth_repository.dart';
import 'package:jaksmok_fe/data/repositories/book_repository.dart';
import 'package:jaksmok_fe/logic/auth/auth_cubit.dart';
import 'package:jaksmok_fe/logic/auth/auth_state.dart';
import 'package:jaksmok_fe/logic/book/book_cubit.dart';
import 'package:jaksmok_fe/ui/screens/home_screen.dart';
import 'package:jaksmok_fe/ui/screens/login_screen.dart';
import 'package:jaksmok_fe/services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final apiService = ApiService();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(apiService: apiService),
        ),
        RepositoryProvider<BookRepository>(
          create: (context) => BookRepository(apiService: apiService),
        ),
      ],

      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthCubit(context.read<AuthRepository>())..checkAuthStatus(),
          ),
          BlocProvider(
            create: (context) => BookCubit(context.read<BookRepository>()),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      home: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthInit) {
            return const Scaffold(
              body: Center(
                child:
                    CircularProgressIndicator(), // Or your custom Splash Screen
              ),
            );
          }
          if (state is AuthAuthenticated) {
            return HomeScreen();
          }

          return LoginScreen();
        },
      ),
    );
  }
}
