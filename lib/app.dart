import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

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
        BlocProvider<TypeSelectionBloc>(create: (BuildContext context) => widget.typeSelectionBloc),
        BlocProvider<TypeDetailsBloc>(create: (BuildContext context) => widget.typeDetailsBloc),
        BlocProvider<PokemonDetailsBloc>(create: (BuildContext context) => widget.pokemonDetailsBloc),
        BlocProvider<WelcomeBloc>(create: (BuildContext context) => widget.welcomeBloc),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: _initialHomePage,
        builder: (context, child) => child!,
        onGenerateTitle: (BuildContext context) => app_const.APP_NAME,
        onGenerateRoute: app_router.Router.generateRoute,
        navigatorObservers: <NavigatorObserver>[app_vars.routeObserver],
        supportedLocales: const <Locale>[Locale('en')],
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          bottomAppBarTheme: const BottomAppBarTheme(elevation: 0, color: app_const.TOTAL_WHITE, shadowColor: Colors.transparent, surfaceTintColor: Colors.transparent),
          scrollbarTheme:
              ScrollbarThemeData(thickness: WidgetStateProperty.all(app_const.SCROLLBAR_THICKNESS), radius: app_const.SCROLLBAR_RADIUS, thumbColor: WidgetStateProperty.all(app_const.SCROLLBAR_COLOR)),
          primaryTextTheme: const TextTheme(titleLarge: TextStyle(color: app_const.PRIMARY_TEXT_COLOR)),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          dividerTheme: const DividerThemeData(color: Colors.black26, endIndent: 30, indent: 30),
        ),
      ),
    );
  }
}
