import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaksmok_fe/core/di/injection.dart';
import 'package:jaksmok_fe/core/localization/codegen_loader.g.dart';
import 'package:jaksmok_fe/core/themes/app_theme.dart';
import 'package:jaksmok_fe/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:jaksmok_fe/features/auth/presentation/cubit/auth_state.dart';
import 'package:jaksmok_fe/features/book/presentation/cubit/book_detail/book_detail_cubit.dart';
import 'package:jaksmok_fe/features/book/presentation/cubit/book_list/book_cubit.dart';
import 'package:jaksmok_fe/features/book/presentation/screens/home_screen.dart';
import 'package:jaksmok_fe/features/auth/presentation/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await init();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US')],
      path: 'assets/translation',
      assetLoader: const CodegenLoader(),

      fallbackLocale: const Locale('en', 'US'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (create) => getIt<AuthCubit>()),
          BlocProvider(create: (create) => getIt<BookCubit>()),
          BlocProvider(create: (create) => getIt<BookDetailCubit>()),
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
      theme: AppTheme.lightTheme,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return state.maybeWhen(
            authenticated: () => const HomeScreen(),
            unauthenticated: () => const LoginScreen(),
            initial: () => const Center(child: CircularProgressIndicator()),
            orElse: () => const LoginScreen(),
          );
        },
      ),
    );
  }
}
