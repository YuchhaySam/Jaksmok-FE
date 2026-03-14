import 'package:flutter/material.dart';

//Define extension on colorScheme so we can
//quickly use it everywhere
extension ContextHelpers on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  ElevatedButtonThemeData get elevatedButtonTheme => theme.elevatedButtonTheme;
  InputDecorationThemeData get inputDecoratorTheme =>
      theme.inputDecorationTheme;

  Color get primary => colorScheme.primary;
  Color get onPrimary => colorScheme.onPrimary;
  Color get surfaceContainerLowest => colorScheme.surfaceContainerLowest;
  Color get surfaceContainerLow => colorScheme.surfaceContainerLow;
  Color get surfaceContainerHigh => colorScheme.surfaceContainerHigh;
  Color get onSurface => colorScheme.onSurface;
  Color get secondary => colorScheme.secondary;
  Color get error => colorScheme.error;
}
