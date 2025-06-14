import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokexplorer/core/common/widgets/bottom_bar.dart';
import 'package:pokexplorer/core/services/routes/route_names.dart';
import 'package:pokexplorer/src/features/type_selection/presentation/pages/type_selection_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RoutePath.onBoardingPage, // Default route

  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navShell) => Scaffold(
        body: navShell,
        bottomNavigationBar: const MyBottomBar(),
      ),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: RoutePath.typeSelectionPage,
              builder: (BuildContext context, GoRouterState state) => const TypeSelectionPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: RoutePath.userFavoritesPage,
              builder: (BuildContext context, GoRouterState state) => const TypeSelectionPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
