import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokexplorer/core/routes/route_names.dart';
import 'package:pokexplorer/core/widgets/main_app_screen.dart';
import 'package:pokexplorer/features/type_selection/presentation/pages/type_selection_page.dart';
import 'package:pokexplorer/features/user_favorites/presentation/page/user_favorites_page.dart';
import 'package:pokexplorer/features/welcome/presentation/pages/welcome_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RoutePath.welcomePage, // Default route
  routes: <RouteBase>[
    // Welcome Screen
    GoRoute(
      path: RoutePath.welcomePage,
      builder: (BuildContext context, GoRouterState state) => const WelcomePage(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) => MainAppScreen(
        child: child,
      ),
      routes: <RouteBase>[
        GoRoute(
          path: RoutePath.typeSelectionPage,
          pageBuilder: (BuildContext context, GoRouterState state) => NoTransitionPage(
            child: TypeSelectionPage(),
          ),
        ),

        // Favorites Screen
        GoRoute(
          path: RoutePath.userFavoritesPage,
          pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
            child: UserFavoritesPage(),
          ),
        ),
      ],
    ),
  ],
);
