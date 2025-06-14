import 'package:flutter/material.dart';
import 'package:pokexplorer/config/theme/app_palette.dart';

class AppTheme {
  static ThemeData getTheme(bool isDark) {
    return ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          // Set the predictive back transitions for Android.
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
        },
      ),
      brightness: isDark ? Brightness.dark : Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? AppPalette.black : AppPalette.white,
        foregroundColor: isDark ? AppPalette.white : AppPalette.black,
      ),
      scaffoldBackgroundColor: isDark ? AppPalette.black : AppPalette.white,
    );
  }
}
