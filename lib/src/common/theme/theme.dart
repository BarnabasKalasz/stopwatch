import 'package:flutter/material.dart';
import 'package:test_sopwatch/src/common/theme/color_scheme.dart';

final ThemeData lightThemeDataCustom = _buildLightTheme();

ThemeData _buildLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: lightColorScheme,
    primaryColor: lightColorScheme.primary,
    scaffoldBackgroundColor: lightColorScheme.background,
  );
}

final ThemeData darkThemeDataCustom = _buildDarkTheme();

ThemeData _buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    colorScheme: darkColorScheme,
    primaryColor: darkColorScheme.primary,
    scaffoldBackgroundColor: darkColorScheme.background,
  );
}
