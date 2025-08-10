import 'package:flutter/material.dart';
import 'package:pokexplorer/config/theme/app_color_scheme.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData light = ThemeData.from(colorScheme: lightColorScheme).copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: lightColorScheme.surface,
      foregroundColor: lightColorScheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: lightColorScheme.surface,
      selectedItemColor: lightColorScheme.primary,
      unselectedItemColor: lightColorScheme.onSurface,
    ),
  );

  static final ThemeData dark = ThemeData.from(colorScheme: darkColorScheme).copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: darkColorScheme.surface,
      foregroundColor: darkColorScheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkColorScheme.surface,
      selectedItemColor: darkColorScheme.primary,
      unselectedItemColor: darkColorScheme.onSurface,
    ),
  );
}
