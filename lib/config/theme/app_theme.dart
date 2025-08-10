import 'package:flutter/material.dart';
import 'package:pokexplorer/config/theme/app_palette.dart';

class AppTheme {
  static ThemeData getTheme(bool isDark) {
    if (isDark) {
      return _getDarkTheme();
    } else {
      return _getLightTheme();
    }
  }
}

ThemeData _getDarkTheme() {
  return ThemeData(
    colorScheme: _getDarkColorScheme(),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        // Set the predictive back transitions for Android.
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      },
    ),
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppPalette.black,
      foregroundColor: AppPalette.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppPalette.white,
      ),
    ),
    scaffoldBackgroundColor: AppPalette.black,
  );
}

ThemeData _getLightTheme() {
  return ThemeData(
    colorScheme: _getLightColorScheme(),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        // Set the predictive back transitions for Android.
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      },
    ),
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: AppPalette.white,
      foregroundColor: AppPalette.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppPalette.black,
      ),
    ),
    scaffoldBackgroundColor: AppPalette.white,
  );
}

ColorScheme _getLightColorScheme() => const ColorScheme(
      brightness: Brightness.light,
      primary: AppColorsScheme.primaryColor,
      onPrimary: AppColorsScheme.onPrimaryColorLight,
      secondary: AppColorsScheme.secondaryColorLight,
      secondaryContainer: AppColorsScheme.secondaryLightVariant,
      onSecondary: AppColorsScheme.onSecondaryColorLight,
      surface: AppColorsScheme.surfaceColorLight,
      onSurface: AppColorsScheme.onSurfaceLight,
      error: AppColorsScheme.errorColor,
      onError: AppColorsScheme.onErrorColor,
    );

ColorScheme _getDarkColorScheme() => const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColorsScheme.primaryColor,
      onPrimary: AppColorsScheme.onPrimaryColorDark,
      secondary: AppColorsScheme.secondaryColorDark,
      onSecondary: AppColorsScheme.onSecondaryColorDark,
      secondaryContainer: AppColorsScheme.secondaryDarkVariant,
      surface: AppColorsScheme.surfaceColorDark,
      onSurface: AppColorsScheme.onSurfaceDark,
      error: AppColorsScheme.errorColor,
      onError: AppColorsScheme.onErrorColor,
    );
