import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/core/theme/bloc/theme_bloc.dart';
import 'package:pokexplorer/core/theme/bloc/theme_state.dart';
import 'package:pokexplorer/core/theme/dark_theme.dart';
import 'package:pokexplorer/core/theme/light_theme.dart';
import 'package:pokexplorer/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:pokexplorer/presentation/home/view/home_screen.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:pokexplorer/presentation/type_selection/bloc/type_selection_bloc.dart';
import 'package:pokexplorer/services/db_service.dart';

import 'core/data_repository/back_end_utils.dart';
import 'core/data_repository/local_data_utils.dart';
import 'core/utilities/app_utils.dart';
import 'core/utilities/front_end_utils.dart';
import 'core/variables/app_constants.dart';
import 'core/variables/app_variables.dart';
import 'presentation/pokemon_details/bloc/pokemon_details_bloc.dart';
import 'presentation/type_details/bloc/type_details_bloc.dart';
import 'presentation/welcome/bloc/welcome_bloc.dart';
import 'presentation/welcome/view/welcome_screen.dart';
import 'router/app_router.dart' as app_router;

part 'core/theme/theme.dart';

/// Custom [BlocObserver] which observes all bloc and cubit instances.
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    AppUtils.myLog(msg: 'onEvent, event = $event');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    AppUtils.myLog(level: LOG_ERROR, msg: 'onError, error = $error');
    super.onError(bloc, error, stackTrace);
  }
}

class PokexplorerApp extends StatefulWidget {
  PokexplorerApp({super.key}) {
    // #region // BLocs register
    backEndUtils = BackendUtils();
    frontEndUtils = FrontendUtils();
    routeObserver.setFrontEndUtils(frontEndUtils);

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
    devicePixelRatio = PlatformDispatcher.instance.implicitView!.devicePixelRatio;
    deviceScreenWidth = PlatformDispatcher.instance.implicitView!.physicalSize.width;
    initBoot = localDataUtils.loadIsInitBootFromPrefs();
    isDarkMode = localDataUtils.loadIsDarkModeFromPrefs();
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
            onGenerateTitle: (BuildContext context) => APP_NAME,
            onGenerateRoute: app_router.Router.generateRoute,
            supportedLocales: const [Locale('en')],
            locale: const Locale('en'), // Set default locale
            navigatorObservers: <NavigatorObserver>[routeObserver],
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: PAppTheme.lightTheme,
            darkTheme: PAppTheme.darkTheme,
          );
        },
      ),
    );
  }
}
