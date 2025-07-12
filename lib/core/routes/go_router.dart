import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokexplorer/core/common/widgets/bottom_bar.dart';
import 'package:pokexplorer/core/routes/route_names.dart';
import 'package:pokexplorer/core/services/injection_container.dart';
import 'package:pokexplorer/features/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:pokexplorer/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:pokexplorer/features/on_boarding/presentation/pages/on_boarding_page.dart';
import 'package:pokexplorer/features/type_selection/presentation/pages/type_selection_page.dart';
import 'package:pokexplorer/features/user_favorites/presentation/page/user_favorites_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final SharedPreferences prefs = sl<SharedPreferences>();
final bool isFirstTimer = prefs.getBool(kFirstTimerKey) ?? true;

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: isFirstTimer ? RoutePath.onBoardingPage : RoutePath.typeSelectionPage, // Default route

  routes: <RouteBase>[
    GoRoute(
      path: RoutePath.onBoardingPage,
      name: RouteName.onBoardingPageName,
      builder: (BuildContext context, GoRouterState state) => BlocProvider<OnBoardingCubit>(
        create: (BuildContext context) => sl<OnBoardingCubit>(),
        child: const OnBoardingPage(),
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navShell) => Scaffold(
        body: navShell,
        bottomNavigationBar: MyBottomBar(
          navigationShell: navShell,
        ),
      ),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: RoutePath.typeSelectionPage,
              name: RouteName.typeSelectionPageName,
              builder: (BuildContext context, GoRouterState state) => const TypeSelectionPage(),
              routes: <GoRoute>[
                GoRoute(
                  path: RoutePath.typeResultsPage,
                  name: RouteName.typeResultsPageName,
                  builder: (BuildContext context, GoRouterState state) => const Placeholder(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: RoutePath.userFavoritesPage,
              name: RouteName.userFavoritesPageName,
              builder: (BuildContext context, GoRouterState state) => const UserFavoritesPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
