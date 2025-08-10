import 'package:flutter/material.dart';

const ColorScheme lightColorScheme = const ColorScheme(
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

const ColorScheme darkColorScheme = const ColorScheme(
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

class AppColorsScheme {
  // Shared across themes
  static const Color primaryColor = Color.fromARGB(255, 235, 37, 37);
  static const Color primaryLight = Color.fromARGB(255, 255, 86, 86);
  static const Color primaryDark = Color.fromARGB(255, 193, 0, 0);

  static const Color onPrimaryColorLight = Color.fromARGB(255, 225, 225, 225);
  static const Color onPrimaryColorDark = Color.fromARGB(255, 34, 34, 34);

//Secondary
  static const Color secondaryColorDark = Color(0xFF212120);
  static const Color secondaryDarkVariant = Color.fromARGB(255, 46, 49, 47);
  static const Color onSecondaryColorDark = Color(0xFF757575);
  static const Color onSecondaryColorDimmedDark = Color(0xFF919191);

  static const Color secondaryColorLight = Color(0xFFE4E4E4);
  static const Color secondaryLightVariant = Color(0xFFDFDDDD);
  static const Color onSecondaryColorLight = Color(0xFFC9C9C9);
  static const Color onSecondaryColorDimmedLight = Color(0xFFA3A3A3);

  //error
  static const Color errorColor = Color(0xFFC92947);
  static const Color onErrorColor = Color(0xFFEDEDED);

//surface
  static const Color surfaceColorLight = Color.fromARGB(255, 235, 235, 235);
  static const Color onSurfaceLight = Color(0xFF212121);

  static const Color mainCardColorDark = Color.fromARGB(199, 88, 88, 88);
  static const Color mainCardColorLight = Color.fromARGB(214, 235, 235, 235);

  static const Color surfaceColorDark = Color(0xFF212120);
  static const Color onSurfaceDark = Color.fromARGB(255, 196, 196, 196);

  static const Color scaffoldDark = Color(0xFF363B38);
  static const Color scaffoldLight = Color(0xFFE2E2E2);
}
