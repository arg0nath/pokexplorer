import 'package:flutter/material.dart';
import 'package:pokexplorer/core/theme/colors/app_palette.dart';

final pDarkTheme = ThemeData(
  // brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(seedColor: AppPalette.primaryColor).copyWith(brightness: Brightness.dark),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      TargetPlatform.iOS: FadeForwardsPageTransitionsBuilder(),
      TargetPlatform.macOS: FadeForwardsPageTransitionsBuilder(),
      TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
      TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
    },
  ),
  shadowColor: AppPalette.shadowDark,
);
