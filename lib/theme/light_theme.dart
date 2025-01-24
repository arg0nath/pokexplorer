part of '../app.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
        TargetPlatform.iOS: FadeThroughPageTransitionsBuilder(),
        TargetPlatform.macOS: FadeThroughPageTransitionsBuilder(),
        TargetPlatform.windows: FadeThroughPageTransitionsBuilder(),
        TargetPlatform.linux: FadeThroughPageTransitionsBuilder(),
      },
    ),
    primaryColor: app_const.BRIGHT_RED,
    canvasColor: app_const.WHITE_TOTAL,
    scaffoldBackgroundColor: app_const.SCAFFOLD_BACKGROUND_LIGHT,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: app_const.WHITE_TOTAL,
      selectedItemColor: app_const.BRIGHT_RED,
      selectedLabelStyle: TextStyle(color: app_const.BRIGHT_RED, fontFamily: app_const.MAIN_FONT_FAMILY),
      showUnselectedLabels: true,
      unselectedItemColor: app_const.SHADOW_COLOR_LIGHT,
      unselectedLabelStyle: TextStyle(color: app_const.SHADOW_COLOR_LIGHT, fontFamily: app_const.MAIN_FONT_FAMILY),
    ),
    popupMenuTheme: const PopupMenuThemeData(
      iconColor: app_const.GREY,
      color: app_const.WHITE_TOTAL,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      textStyle: TextStyle(fontSize: 16, color: app_const.GREY, fontFamily: app_const.MAIN_FONT_FAMILY),
    ),
    dialogBackgroundColor: app_const.WHITE_TOTAL,
    shadowColor: app_const.SHADOW_COLOR_LIGHT,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: app_const.WHITE_TOTAL,
      filled: true,
      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 0.5, color: app_const.WHITE_TOTAL), borderRadius: BorderRadius.circular(15)),
      border: OutlineInputBorder(borderSide: const BorderSide(width: 0.5, color: app_const.WHITE_TOTAL), borderRadius: BorderRadius.circular(15)),
      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 0.5, color: app_const.WHITE_TOTAL), borderRadius: BorderRadius.circular(15)),
      hintStyle: const TextStyle(fontSize: 16, color: app_const.GREY, fontFamily: app_const.MAIN_FONT_FAMILY),
    ),
    appBarTheme: const AppBarTheme(
      color: app_const.APPBAR_BACKGROUND_LIGHT,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: app_const.BLACK_IOS, fontFamily: app_const.MAIN_FONT_FAMILY),
    ),
    listTileTheme: const ListTileThemeData(
      selectedColor: app_const.BRIGHT_RED,
      titleTextStyle: TextStyle(fontSize: 16, color: app_const.GREY, fontFamily: app_const.MAIN_FONT_FAMILY),
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: app_const.WHITE_IOS),
    toggleButtonsTheme: const ToggleButtonsThemeData(selectedColor: app_const.BRIGHT_RED, disabledColor: Color(0xFFEEEEEE)),
    cardColor: app_const.CARD_LIGHT,
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 19, color: app_const.WHITE_TOTAL, fontWeight: FontWeight.bold, fontFamily: app_const.MAIN_FONT_FAMILY)),
            side: WidgetStateProperty.all(const BorderSide(width: 1, color: app_const.LIGHT_RED)),
            foregroundColor: WidgetStateProperty.all(app_const.WHITE_IOS),
            backgroundColor: WidgetStateProperty.all(app_const.BRIGHT_RED))),
    textTheme: const TextTheme(
      bodySmall: TextStyle(fontSize: 16, color: app_const.GREY, fontFamily: app_const.MAIN_FONT_FAMILY),
      bodyLarge: TextStyle(fontSize: 20, color: app_const.BLACK_IOS, fontFamily: app_const.MAIN_FONT_FAMILY),
      bodyMedium: TextStyle(fontSize: 18, color: app_const.BLACK_IOS, fontFamily: app_const.MAIN_FONT_FAMILY),
      titleLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: app_const.BLACK_IOS, fontFamily: app_const.MAIN_FONT_FAMILY),
      titleMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: app_const.BLACK_IOS, fontFamily: app_const.MAIN_FONT_FAMILY),
      titleSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: app_const.BLACK_IOS, fontFamily: app_const.MAIN_FONT_FAMILY),
      labelMedium: TextStyle(fontSize: 18, color: app_const.BLACK_IOS, fontFamily: app_const.MAIN_FONT_FAMILY),
      labelSmall: TextStyle(fontSize: 16, color: app_const.BLACK_IOS, fontFamily: app_const.MAIN_FONT_FAMILY),
    ),
  );
}
