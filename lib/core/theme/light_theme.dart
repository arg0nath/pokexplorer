import 'package:flutter/material.dart';
import 'package:pokexplorer/core/theme/colors/app_palette.dart';

final pLightTheme = ThemeData(
  useMaterial3: true,
  // brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: AppPalette.primaryColor).copyWith(
    brightness: Brightness.light,
  ),
  shadowColor: AppPalette.shadowLight,
  dialogTheme: const DialogThemeData(backgroundColor: AppPalette.white, elevation: 0),

  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      TargetPlatform.iOS: FadeForwardsPageTransitionsBuilder(),
      TargetPlatform.macOS: FadeForwardsPageTransitionsBuilder(),
      TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
      TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
    },
  ),
);
