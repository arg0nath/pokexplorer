import 'package:flutter/material.dart';
import 'package:pokexplorer/config/theme/app_color_scheme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final ThemeData _theme = ThemeData.from(colorScheme: lightColorScheme);
    return _theme.copyWith(
      appBarTheme: _theme.appBarTheme.copyWith(
        backgroundColor: lightColorScheme.surface,
        foregroundColor: lightColorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      bottomNavigationBarTheme: _theme.bottomNavigationBarTheme.copyWith(
        backgroundColor: lightColorScheme.surface,
        selectedItemColor: lightColorScheme.primary,
        unselectedItemColor: lightColorScheme.onSurface,
      ),
      cardColor: lightColorScheme.onSecondaryContainer,
    );
  }

  static ThemeData dark() {
    final ThemeData _theme = ThemeData.from(colorScheme: darkColorScheme);
    return _theme.copyWith(
      appBarTheme: _theme.appBarTheme.copyWith(
        backgroundColor: darkColorScheme.surface,
        foregroundColor: darkColorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      bottomNavigationBarTheme: _theme.bottomNavigationBarTheme.copyWith(
        backgroundColor: darkColorScheme.surface,
        selectedItemColor: darkColorScheme.primary,
        unselectedItemColor: darkColorScheme.onSurface,
      ),
      cardColor: darkColorScheme.onSecondaryContainer,
    );
  }
}
