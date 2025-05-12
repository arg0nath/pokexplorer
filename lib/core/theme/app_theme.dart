import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme(bool isDark) {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? Colors.black : Colors.white,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      scaffoldBackgroundColor: isDark ? Colors.black : Colors.white,
    );
  }
}
