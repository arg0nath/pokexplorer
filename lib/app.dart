import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/screens/favorites/bloc/favorites_bloc.dart';
import 'package:pokexplorer/screens/home/view/home_screen.dart';
import 'package:pokexplorer/services/db_service.dart';
import 'package:pokexplorer/theme/bloc/theme_bloc.dart';
import 'package:pokexplorer/theme/bloc/theme_state.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:pokexplorer/screens/type_selection/bloc/type_selection_bloc.dart';

import 'core/data_repository/back_end_utils.dart';
import 'core/data_repository/local_data_utils.dart';
import 'core/utilities/app_utils.dart' as app_utils;
import 'core/variables/app_constants.dart' as app_const;
import 'core/variables/app_variables.dart' as app_vars;

import 'core/utilities/front_end_utils.dart';
import 'router/app_router.dart' as app_router;

import 'screens/pokemon_details/bloc/pokemon_details_bloc.dart';
import 'screens/type_details/bloc/type_details_bloc.dart';

import 'screens/welcome/bloc/welcome_bloc.dart';
import 'screens/welcome/view/welcome_screen.dart';

part './theme/light_theme.dart';
part './theme/dark_theme.dart';

/// Custom [BlocObserver] which observes all bloc and cubit instances.
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    app_utils.myLog(msg: 'onEvent, event = $event');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    app_utils.myLog(level: app_const.LOG_ERROR, msg: 'onError, error = $error');
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
    userFavoritesBloc = UserFavoritesBloc(frontEndUtils: frontEndUtils);
    typeSelectionBloc = TypeSelectionBloc(frontEndUtils: frontEndUtils);

    typeDetailsBloc = TypeDetailsBloc(frontEndUtils: frontEndUtils);
    typeDetailsBloc.setUserFavoritesBloc(userFavoritesBloc);
    pokemonDetailsBloc = PokemonDetailsBloc(frontEndUtils: frontEndUtils);
    pokemonDetailsBloc.setTypeDetailsBloc(typeDetailsBloc);
    // #endregion
  }
  // #region // BLocs etc

  late final FrontendUtils frontEndUtils;
  late final BackendUtils backEndUtils;

  late final WelcomeBloc welcomeBloc;
  late final ThemeBloc themeBloc;
  late final TypeSelectionBloc typeSelectionBloc;
  late final TypeDetailsBloc typeDetailsBloc;
  late final UserFavoritesBloc userFavoritesBloc;
  late final PokemonDetailsBloc pokemonDetailsBloc;

  // #endregion
  @override
  State<PokexplorerApp> createState() => _PokexplorerAppState();
}

class _PokexplorerAppState extends State<PokexplorerApp> {
  // final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: 'Main Navigator');
  Widget _initialHomePage = const HomeScreen(); // home page
  LocalDataUtils localDataUtils = const LocalDataUtils();
  late FrontendUtils frontEndUtils = widget.frontEndUtils;
  late bool initBoot = true;
  late bool hasSelectedType = false;
  late DatabaseService databaseService = DatabaseService.instance;

  @override
  void initState() {
    app_vars.devicePixelRatio = PlatformDispatcher.instance.implicitView!.devicePixelRatio;
    app_vars.deviceScreenWidth = PlatformDispatcher.instance.implicitView!.physicalSize.width;
    initBoot = localDataUtils.loadIsInitBootFromPrefs();
    app_vars.isDarkMode = localDataUtils.loadIsDarkModeFromPrefs();
    _initialHomePage = initBoot ? const WelcomeScreen() : const HomeScreen();

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
        BlocProvider<UserFavoritesBloc>(create: (BuildContext context) => widget.userFavoritesBloc),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
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
