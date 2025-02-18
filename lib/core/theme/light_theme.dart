import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/constants/app_constants.dart';
import 'package:pokexplorer/core/theme/colors/app_palette.dart';

final ColorScheme _colorScheme = ColorScheme.fromSeed(
  seedColor: AppPalette.grey,
  brightness: Brightness.light,
  dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
);

final _dialogTheme = DialogThemeData(
  backgroundColor: _colorScheme.onPrimary,
);

const TextStyle _textThemeData = TextStyle(fontFamily: MAIN_FONT_FAMILY);

final _elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    textStyle: WidgetStatePropertyAll(_textThemeData.copyWith(fontSize: 18, fontWeight: FontWeight.w600)),
    foregroundColor: const WidgetStatePropertyAll(AppPalette.whitish),
    backgroundColor: const WidgetStatePropertyAll(AppPalette.brightRed),
  ),
);

final _inputDecorationTheme = const InputDecorationTheme().copyWith(
  fillColor: AppPalette.white,
  filled: true,
  labelStyle: _textThemeData.copyWith(color: _colorScheme.primary),
  hintStyle: _textThemeData.copyWith(color: _colorScheme.primary),
  suffixIconColor: AppPalette.grey,
  focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 0.5, color: AppPalette.whitish), borderRadius: BorderRadius.circular(CIRCULAR_RADIUS)),
  border: OutlineInputBorder(borderSide: const BorderSide(width: 0.5, color: AppPalette.whitish), borderRadius: BorderRadius.circular(CIRCULAR_RADIUS)),
  enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 0.5, color: AppPalette.whitish), borderRadius: BorderRadius.circular(CIRCULAR_RADIUS)),
);

final pLightTheme = ThemeData(
  // brightness: Brightness.light,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(elevation: 0.2),
  colorScheme: _colorScheme,

  dialogTheme: _dialogTheme,
  elevatedButtonTheme: _elevatedButtonTheme,
  fontFamily: MAIN_FONT_FAMILY,
  inputDecorationTheme: _inputDecorationTheme,
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
