import 'package:flutter/material.dart';
import 'package:pokexplorer/config/theme/app_color_scheme.dart';
import 'package:pokexplorer/config/theme/app_palette.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/res/app_assets.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final ThemeData _theme = ThemeData.from(colorScheme: lightColorScheme);
    return _theme.copyWith(
      textTheme: _theme.textTheme.apply(fontFamily: AppAssets.comfortaa),
      pageTransitionsTheme: _pageTransition,
      appBarTheme: _theme.appBarTheme.copyWith(
        backgroundColor: lightColorScheme.surface,
        foregroundColor: lightColorScheme.onSurface,
        titleTextStyle: _theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: AppAssets.comfortaa,
        ),
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
        titleTextStyle: _theme.textTheme.titleLarge?.copyWith(
          color: lightColorScheme.onSurface,
          fontFamily: AppAssets.comfortaa,
        ),
        contentTextStyle: _theme.textTheme.bodyMedium?.copyWith(
          color: lightColorScheme.onSurface,
          fontFamily: AppAssets.comfortaa,
        ),
      ),
      inputDecorationTheme: _theme.inputDecorationTheme.copyWith(
        fillColor: AppPalette.white,
        filled: true,
        labelStyle: _theme.textTheme.labelMedium?.copyWith(
          color: AppPalette.grey,
          fontFamily: AppAssets.comfortaa,
        ),
        hintStyle: _theme.textTheme.labelMedium?.copyWith(
          color: AppPalette.grey,
          fontFamily: AppAssets.comfortaa,
        ),
        suffixIconColor: AppPalette.grey,
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 0.5, color: AppPalette.white), borderRadius: AppConst.mainRadius),
        border: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: AppPalette.white), borderRadius: AppConst.mainRadius),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 0.5, color: AppPalette.white), borderRadius: AppConst.mainRadius),
      ),
      floatingActionButtonTheme: _theme.floatingActionButtonTheme.copyWith(
        backgroundColor: lightColorScheme.primary,
        foregroundColor: lightColorScheme.onPrimary,
        extendedTextStyle: _theme.textTheme.displayMedium?.copyWith(
          fontWeight: FontWeight.bold,
          fontFamily: AppAssets.comfortaa,
        ),
      ),
      scaffoldBackgroundColor: lightColorScheme.surface,
      cardColor: AppPalette.white,
    );
  }

  static ThemeData dark() {
    final ThemeData _theme = ThemeData.from(colorScheme: darkColorScheme);
    return _theme.copyWith(
      textTheme: _theme.textTheme.apply(fontFamily: AppAssets.comfortaa),
      pageTransitionsTheme: _pageTransition,
      appBarTheme: _theme.appBarTheme.copyWith(
        backgroundColor: darkColorScheme.surface,
        foregroundColor: darkColorScheme.onSurface,
        titleTextStyle: _theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: AppAssets.comfortaa,
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      bottomNavigationBarTheme: _theme.bottomNavigationBarTheme.copyWith(
        backgroundColor: darkColorScheme.surface,
        selectedItemColor: darkColorScheme.primary,
        unselectedItemColor: darkColorScheme.onSurface.withAlpha(100),
      ),
      inputDecorationTheme: _theme.inputDecorationTheme.copyWith(
        fillColor: AppPalette.black,
        filled: true,
        labelStyle: _theme.textTheme.labelMedium?.copyWith(
          color: AppPalette.grey,
          fontFamily: AppAssets.comfortaa,
        ),
        hintStyle: _theme.textTheme.labelMedium?.copyWith(
          color: AppPalette.grey,
          fontFamily: AppAssets.comfortaa,
        ),
        suffixIconColor: AppPalette.grey,
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 0.5, color: AppPalette.black), borderRadius: AppConst.mainRadius),
        border: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: AppPalette.black), borderRadius: AppConst.mainRadius),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 0.5, color: AppPalette.black), borderRadius: AppConst.mainRadius),
      ),
      shadowColor: AppPalette.shadowDark,
      dialogTheme: _theme.dialogTheme.copyWith(
        backgroundColor: darkColorScheme.surface,
        titleTextStyle: _theme.textTheme.titleLarge?.copyWith(
          color: darkColorScheme.onSurface,
          fontFamily: AppAssets.comfortaa,
        ),
        contentTextStyle: _theme.textTheme.bodyMedium?.copyWith(
          color: darkColorScheme.onSurface,
          fontFamily: AppAssets.comfortaa,
        ),
      ),
      floatingActionButtonTheme: _theme.floatingActionButtonTheme.copyWith(
        backgroundColor: darkColorScheme.primary,
        foregroundColor: darkColorScheme.onPrimary,
        extendedTextStyle: _theme.textTheme.displayMedium?.copyWith(
          fontWeight: FontWeight.bold,
          fontFamily: AppAssets.comfortaa,
        ),
      ),
      scaffoldBackgroundColor: darkColorScheme.surface,
      cardColor: AppPalette.black,
    );
  }
}

const PageTransitionsTheme _pageTransition = PageTransitionsTheme(
  builders: <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
    TargetPlatform.iOS: FadeForwardsPageTransitionsBuilder(),
    TargetPlatform.macOS: FadeForwardsPageTransitionsBuilder(),
    TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
    TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
  },
);
