import 'package:flutter/material.dart';
import 'package:pokexplorer/config/theme/app_color_scheme.dart';
import 'package:pokexplorer/config/theme/app_palette.dart';
import 'package:pokexplorer/core/common/res/app_assets.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final ThemeData _theme = ThemeData.from(colorScheme: lightColorScheme)..textTheme.apply(fontFamily: AppAssets.fontFamily);
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
        unselectedItemColor: lightColorScheme.onSurface.withAlpha(100),
      ),
      shadowColor: AppPalette.shadowLight,
      dialogTheme: _theme.dialogTheme.copyWith(
        backgroundColor: lightColorScheme.surface,
        titleTextStyle: _theme.textTheme.titleLarge?.copyWith(color: lightColorScheme.onSurface),
        contentTextStyle: _theme.textTheme.bodyMedium?.copyWith(color: lightColorScheme.onSurface),
      ),
      floatingActionButtonTheme: _theme.floatingActionButtonTheme.copyWith(
        backgroundColor: lightColorScheme.primary,
        foregroundColor: lightColorScheme.onPrimary,
        extendedTextStyle: _theme.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      scaffoldBackgroundColor: lightColorScheme.surface,
      cardColor: AppPalette.white,
    );
  }

  static ThemeData dark() {
    final ThemeData _theme = ThemeData.from(colorScheme: darkColorScheme)..textTheme.apply(fontFamily: AppAssets.fontFamily);
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
        unselectedItemColor: darkColorScheme.onSurface.withAlpha(100),
      ),
      shadowColor: AppPalette.shadowDark,
      dialogTheme: _theme.dialogTheme.copyWith(
        backgroundColor: darkColorScheme.surface,
        titleTextStyle: _theme.textTheme.titleLarge?.copyWith(color: darkColorScheme.onSurface),
        contentTextStyle: _theme.textTheme.bodyMedium?.copyWith(color: darkColorScheme.onSurface),
      ),
      floatingActionButtonTheme: _theme.floatingActionButtonTheme.copyWith(
        backgroundColor: darkColorScheme.primary,
        foregroundColor: darkColorScheme.onPrimary,
        extendedTextStyle: _theme.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      scaffoldBackgroundColor: darkColorScheme.surface,
      cardColor: AppPalette.black,
    );
  }
}
