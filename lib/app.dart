import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pokexplorer/screens/theme/bloc/theme_bloc.dart';
import 'package:pokexplorer/screens/theme/bloc/theme_state.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:pokexplorer/screens/type_selection/bloc/type_selection_bloc.dart';
import 'package:pokexplorer/screens/type_selection/view/type_selection_screen.dart';

import 'src/data_repository/back_end_utils.dart';
import 'src/data_repository/local_data_utils.dart';
import 'src/utilities/app_utils.dart' as app_utils;
import 'src/variables/app_constants.dart' as app_const;
import 'src/variables/app_variables.dart' as app_vars;

import 'src/utilities/front_end_utils.dart';
import 'router/app_router.dart' as app_router;

import 'screens/pokemon_details/bloc/pokemon_details_bloc.dart';
import 'screens/type_details/bloc/type_details_bloc.dart';

import 'screens/welcome/bloc/welcome_bloc.dart';
import 'screens/welcome/view/welcome_screen.dart';

/// Custom [BlocObserver] which observes all bloc and cubit instances.
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    app_utils.myLog(app_const.LOG_INFO, 'onEvent, event = $event');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    app_utils.myLog(app_const.LOG_ERROR, 'onError, error = $error');
    super.onError(bloc, error, stackTrace);
  }
}

class PokexplorerApp extends StatefulWidget {
  PokexplorerApp({super.key}) {
    // #region // BLocs register
    backEndUtils = BackendUtils();
    frontEndUtils = FrontendUtils();
    app_vars.routeObserver.setFrontEndUtils(frontEndUtils);

    themeBloc = ThemeBloc(frontEndUtils: frontEndUtils);
    welcomeBloc = WelcomeBloc(frontEndUtils: frontEndUtils);
    typeSelectionBloc = TypeSelectionBloc(frontEndUtils: frontEndUtils);
    typeDetailsBloc = TypeDetailsBloc(frontEndUtils: frontEndUtils);
    pokemonDetailsBloc = PokemonDetailsBloc(frontEndUtils: frontEndUtils);

    // #endregion
  }
  // #region // BLocs etc

  late final FrontendUtils frontEndUtils;
  late final BackendUtils backEndUtils;

  late final WelcomeBloc welcomeBloc;
  late final ThemeBloc themeBloc;
  late final TypeSelectionBloc typeSelectionBloc;
  late final TypeDetailsBloc typeDetailsBloc;
  late final PokemonDetailsBloc pokemonDetailsBloc;

  // #endregion
  @override
  State<PokexplorerApp> createState() => _PokexplorerAppState();
}

class _PokexplorerAppState extends State<PokexplorerApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: 'Main Navigator');
  Widget _initialHomePage = const TypeSelectionScreen(); // home page
  LocalDataUtils localDataUtils = const LocalDataUtils();
  late FrontendUtils frontEndUtils = widget.frontEndUtils;
  late bool initBoot = true;
  late bool hasSelectedType = false;

  @override
  void initState() {
    app_vars.devicePixelRatio = PlatformDispatcher.instance.implicitView!.devicePixelRatio;
    app_vars.deviceScreenWidth = PlatformDispatcher.instance.implicitView!.physicalSize.width;
    initBoot = localDataUtils.loadIsInitBootFromPrefs();
    app_vars.isDarkMode = localDataUtils.loadIsDarkModeFromPrefs();

    _initialHomePage = initBoot ? const WelcomeScreen() : const TypeSelectionScreen();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<ThemeBloc>(create: (BuildContext context) => widget.themeBloc),
        BlocProvider<TypeSelectionBloc>(create: (BuildContext context) => widget.typeSelectionBloc),
        BlocProvider<TypeDetailsBloc>(create: (BuildContext context) => widget.typeDetailsBloc),
        BlocProvider<PokemonDetailsBloc>(create: (BuildContext context) => widget.pokemonDetailsBloc),
        BlocProvider<WelcomeBloc>(create: (BuildContext context) => widget.welcomeBloc),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            home: _initialHomePage,
            builder: (context, child) => child!,
            onGenerateTitle: (BuildContext context) => app_const.APP_NAME,
            onGenerateRoute: app_router.Router.generateRoute,
            supportedLocales: const [Locale('en')],
            locale: const Locale('en'), // Set default locale
            navigatorObservers: <NavigatorObserver>[app_vars.routeObserver],
            themeMode: app_vars.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: lightTheme(),
            darkTheme: darkTheme(),
          );
        },
      ),
    );
  }
}

lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: app_const.SCAFFOLD_BACKGROUND_LIGHT,
    dialogBackgroundColor: app_const.WHITE_TOTAL,
    shadowColor: app_const.SHADOW_COLOR_LIGHT,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: app_const.WHITE_TOTAL,
      filled: true,
      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 0.5, color: app_const.WHITE_TOTAL), borderRadius: BorderRadius.circular(15)),
      border: OutlineInputBorder(borderSide: const BorderSide(width: 0.5, color: app_const.WHITE_TOTAL), borderRadius: BorderRadius.circular(15)),
      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 0.5, color: app_const.WHITE_TOTAL), borderRadius: BorderRadius.circular(15)),
      hintStyle: TextStyle(fontSize: 16, color: app_const.GREY, fontFamily: app_const.MAIN_FONT_FAMILY),
    ),
    appBarTheme: const AppBarTheme(
      color: app_const.APPBAR_BACKGROUND_LIGHT,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: app_const.BLACK_IOS, fontFamily: app_const.MAIN_FONT_FAMILY),
    ),
    toggleButtonsTheme: const ToggleButtonsThemeData(selectedColor: app_const.BRIGHT_RED, disabledColor: Color(0xFFEEEEEE)),
    cardColor: app_const.CARD_LIGHT,
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            textStyle: WidgetStateProperty.all(TextStyle(fontSize: 19, color: app_const.WHITE_TOTAL, fontWeight: FontWeight.bold, fontFamily: app_const.MAIN_FONT_FAMILY)),
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

darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    shadowColor: app_const.SHADOW_COLOR_DARK,
    scaffoldBackgroundColor: app_const.SCAFFOLD_BACKGROUND_DARK,
    toggleButtonsTheme: const ToggleButtonsThemeData(selectedColor: app_const.BRIGHT_RED, disabledColor: Color(0xFFC4C4C4)),
    dialogBackgroundColor: app_const.CARD_DARK,
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            textStyle: WidgetStateProperty.all(TextStyle(fontSize: 19, color: app_const.WHITE_TOTAL, fontWeight: FontWeight.bold, fontFamily: app_const.MAIN_FONT_FAMILY)),
            side: WidgetStateProperty.all(const BorderSide(width: 1, color: app_const.LIGHT_RED)),
            foregroundColor: WidgetStateProperty.all(app_const.WHITE_IOS),
            backgroundColor: WidgetStateProperty.all(app_const.BRIGHT_RED))),
    appBarTheme: const AppBarTheme(
      color: app_const.APPBAR_BACKGROUND_DARK,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: app_const.WHITE_IOS, fontFamily: app_const.MAIN_FONT_FAMILY),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: app_const.WHITE_TOTAL,
      filled: true,
      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 0.5, color: app_const.WHITE_TOTAL), borderRadius: BorderRadius.circular(15)),
      border: OutlineInputBorder(borderSide: const BorderSide(width: 0.5, color: app_const.WHITE_TOTAL), borderRadius: BorderRadius.circular(15)),
      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 0.5, color: app_const.WHITE_TOTAL), borderRadius: BorderRadius.circular(15)),
      hintStyle: TextStyle(fontSize: 16, color: app_const.GREY, fontFamily: app_const.MAIN_FONT_FAMILY),
    ),
    cardColor: app_const.CARD_DARK,
    textTheme: const TextTheme(
      bodySmall: TextStyle(fontSize: 16, color: app_const.GREY, fontFamily: app_const.MAIN_FONT_FAMILY),
      bodyLarge: TextStyle(fontSize: 20, color: app_const.WHITE_IOS, fontFamily: app_const.MAIN_FONT_FAMILY),
      bodyMedium: TextStyle(fontSize: 18, color: app_const.WHITE_IOS, fontFamily: app_const.MAIN_FONT_FAMILY),
      titleLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: app_const.WHITE_IOS, fontFamily: app_const.MAIN_FONT_FAMILY),
      titleMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: app_const.WHITE_IOS, fontFamily: app_const.MAIN_FONT_FAMILY),
      titleSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: app_const.WHITE_IOS, fontFamily: app_const.MAIN_FONT_FAMILY),
      labelMedium: TextStyle(fontSize: 18, color: app_const.WHITE_IOS, fontFamily: app_const.MAIN_FONT_FAMILY),
      labelSmall: TextStyle(fontSize: 16, color: app_const.WHITE_IOS, fontFamily: app_const.MAIN_FONT_FAMILY),
    ),
  );
}
