import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/constants/app_constants.dart';
import 'package:pokexplorer/core/theme/colors/app_palette.dart';

final ColorScheme _colorScheme = ColorScheme.fromSeed(seedColor: AppPalette.grey, primary: AppPalette.grey, brightness: Brightness.dark);

final pDarkTheme = ThemeData(
  // brightness: Brightness.light,
  colorScheme: _colorScheme,
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(AppPalette.whitish),
      backgroundColor: WidgetStatePropertyAll(AppPalette.brightRed), //red
    ),
  ),

  dialogTheme: DialogThemeData(backgroundColor: _colorScheme.onInverseSurface),

  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      TargetPlatform.iOS: FadeForwardsPageTransitionsBuilder(),
      TargetPlatform.macOS: FadeForwardsPageTransitionsBuilder(),
      TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
      TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
    },
  ),

  fontFamily: MAIN_FONT_FAMILY,
  inputDecorationTheme: InputDecorationTheme().copyWith(
    fillColor: AppPalette.whitish,
    filled: true,
    hintStyle: const TextStyle().copyWith(color: AppPalette.grey),
    labelStyle: const TextStyle().copyWith(color: AppPalette.grey),
    suffixIconColor: AppPalette.grey,
    focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 0.5, color: AppPalette.whitish), borderRadius: BorderRadius.circular(CIRCULAR_RADIUS)),
    border: OutlineInputBorder(borderSide: const BorderSide(width: 0.5, color: AppPalette.whitish), borderRadius: BorderRadius.circular(CIRCULAR_RADIUS)),
    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 0.5, color: AppPalette.whitish), borderRadius: BorderRadius.circular(CIRCULAR_RADIUS)),
  ),
);
