import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokexplorer/core/common/widgets/bottom_bar.dart';
import 'package:pokexplorer/core/routes/route_helper.dart';
import 'package:pokexplorer/core/routes/route_names.dart';
import 'package:pokexplorer/core/services/di_imports.dart';
import 'package:pokexplorer/features/debug/presentation/pages/debug_page.dart';
import 'package:pokexplorer/features/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:pokexplorer/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:pokexplorer/features/on_boarding/presentation/pages/on_boarding_page.dart';
import 'package:pokexplorer/features/pokemon_details/presentation/bloc/pokemon_details_bloc.dart';
import 'package:pokexplorer/features/pokemon_details/presentation/pages/pokemon_details_page.dart';
import 'package:pokexplorer/features/settings/presentation/pages/settings_page.dart';
import 'package:pokexplorer/features/type_details/presentation/bloc/type_details_bloc.dart';
import 'package:pokexplorer/features/type_details/presentation/pages/type_details_page.dart';
import 'package:pokexplorer/features/type_selection/presentation/pages/type_selection_page.dart';
import 'package:pokexplorer/features/user_favorites/presentation/pages/user_favorites_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final SharedPreferences prefs = sl<SharedPreferences>();
final bool isFirstTimer = prefs.getBool(kFirstTimerKey) ?? true;
final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: isFirstTimer ? RoutePath.onBoardingPage : RoutePath.typeSelectionPage,
  redirect: (BuildContext context, GoRouterState state) => state.matchedLocation == RoutePath.rootPage ? RoutePath.typeSelectionPage : null,
  routes: <RouteBase>[
    customGoRoute(
      path: RoutePath.onBoardingPage,
      name: RouteName.onBoardingPageName,
      builder: (BuildContext context, GoRouterState state) => BlocProvider<OnBoardingCubit>(
        create: (BuildContext context) => sl<OnBoardingCubit>(),
        child: const OnBoardingPage(),
      ),
    ),
    customGoRoute(
      path: '${RoutePath.pokemonDetailsPage}/:pokemonName',
      name: RouteName.pokemonDetailsPageName,
      builder: (BuildContext context, GoRouterState state) => BlocProvider<PokemonDetailsBloc>(
        create: (BuildContext context) => sl<PokemonDetailsBloc>(),
        child: PokemonDetailsPage(
          name: state.pathParameters['pokemonName']!,
        ),
      ),
    ),
    customGoRoute(
      path: '${RoutePath.debugPage}',
      name: RouteName.debugPageName,
      builder: (BuildContext context, GoRouterState state) => DebugPage(),
    ),
    customGoRoute(
      path: '${RoutePath.typeDetailsPage}/:typeName',
      name: RouteName.typeDetailsPageName,
      builder: (BuildContext context, GoRouterState state) => BlocProvider<TypeDetailsBloc>(
        create: (BuildContext context) => sl<TypeDetailsBloc>(),
        child: TypeDetailsPage(
          typeName: state.pathParameters['typeName']!,
        ),
      ),
    ),
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navShell) => Scaffold(
        body: navShell,
        bottomNavigationBar: MainAppBottomBar(navigationShell: navShell),
      ),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <RouteBase>[
            customGoRoute(
              path: RoutePath.typeSelectionPage,
              name: RouteName.typeSelectionPageName,
              builder: (BuildContext context, GoRouterState state) => const TypeSelectionPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            customGoRoute(
              path: RoutePath.userFavoritesPage,
              name: RouteName.userFavoritesPageName,
              builder: (BuildContext context, GoRouterState state) => const UserFavoritesPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            customGoRoute(
              path: RoutePath.settingsPage,
              name: RouteName.settingsPageName,
              builder: (BuildContext context, GoRouterState state) => const SettingsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
