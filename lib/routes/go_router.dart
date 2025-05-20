import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokexplorer/features/type_selection/presentation/pages/type_selection_page.dart';
import 'package:pokexplorer/features/welcome/presentation/pages/welcome_page.dart';
import 'package:pokexplorer/routes/route_names.dart';

final GoRouter router = GoRouter(
  initialLocation: RouteNames.welcomePage, // Default route
  routes: <RouteBase>[
    // Welcome Screen
    GoRoute(
      path: RouteNames.welcomePage,
      builder: (BuildContext context, GoRouterState state) => const WelcomePage(),
    ),

    // Type Selection Screen
    GoRoute(
      path: RouteNames.typeSelectionPage,
      builder: (BuildContext context, GoRouterState state) => const TypeSelectionPage(),
    ),
    // Type Details Screen (with arguments)
    /*  GoRoute(
      path: RouteNames.typeResultsPage,
      builder: (BuildContext context, GoRouterState state) {
        // final TypeDetailsScreenArguments args = state.extra as TypeDetailsScreenArguments;
        return const TypeResultsPage();
      },
    ),
    // Pokemon Details Screen (with arguments)
    GoRoute(
      path: RouteNames.pokemonDetailsPage,
      builder: (BuildContext context, GoRouterState state) {
        // final PokemonDetailsScreenArguments args = state.extra as PokemonDetailsScreenArguments;
        return const PokemonDetailsPage();
      },
    ),
    // Favorites Screen
    GoRoute(
      path: RouteNames.userFavoritesPage,
      builder: (BuildContext context, GoRouterState state) => const UserFavoritesPage(),
    ), */
  ],
);
