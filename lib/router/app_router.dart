import 'package:flutter/material.dart';
import 'package:pokexplorer/presentation/favorites/view/favorites_screen.dart';
import 'package:pokexplorer/presentation/home/view/home_screen.dart';
import 'package:pokexplorer/presentation/type_selection/view/type_selection_screen.dart';

import '../core/models/app_models.dart' as app_models;
import '../domain/front_end_utils.dart';
import '../presentation/pokemon_details/view/pokemon_details_screen.dart';
import '../presentation/type_details/view/type_details_screen.dart';
import '../presentation/welcome/welcome.dart';

// #region // * Arguments

class PokemonDetailsScreenArguments {
  PokemonDetailsScreenArguments({
    required this.pokemon,
    required this.selectedTypeName,
  });

  final app_models.Pokemon pokemon;
  final String selectedTypeName;
}

class TypeDetailsScreenArguments {
  TypeDetailsScreenArguments({required this.typeDetails});

  final app_models.PokemonTypeDetails typeDetails;
}
// #endregion

/// Class that extends the RouteObserver for monitoring the currently visible screen.
class MyRouteObserver extends RouteObserver<Route<dynamic>> {
  FrontendUtils? frontEndUtils;
  void setFrontEndUtils(FrontendUtils frontEndUtilities) => frontEndUtils = frontEndUtilities;
}

abstract class RouteNames {
  static const String homeScreen = 'homeScreen';
  static const String typeDetailsScreen = 'typeDetailsScreen';
  static const String typeSelectionScreen = 'typeSelectionScreen';
  static const String pokeDetailsScreen = 'pokeDetailsScreen';
  static const String welcomeScreen = 'welcomeScreen';
  static const String favoritesScreen = 'favoritesScreen';
}

/// Class that implements a callback for managing page transition when the app is navigated to a named route. (+a smooth fade animation for each screen)
class RouterClass {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.typeDetailsScreen:
        final TypeDetailsScreenArguments args = settings.arguments! as TypeDetailsScreenArguments;
        return MaterialPageRoute(builder: (context) => TypeDetailsScreen(typeDetails: args.typeDetails));
      case RouteNames.typeSelectionScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.typeSelectionScreen),
          builder: (_) => const TypeSelectionScreen(),
        );
      case RouteNames.homeScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.homeScreen),
          builder: (_) => const HomeScreen(),
        );
      case RouteNames.favoritesScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.favoritesScreen),
          builder: (_) => const FavoritesScreen(),
        );
      case RouteNames.welcomeScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.welcomeScreen),
          builder: (_) => const WelcomeScreen(),
        );
      case RouteNames.pokeDetailsScreen:
        final PokemonDetailsScreenArguments args = settings.arguments! as PokemonDetailsScreenArguments;
        return MaterialPageRoute(
          builder: (context) => PokemonDetailsScreen(pokemon: args.pokemon, selectedTypeName: args.selectedTypeName),
        );
      default:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.homeScreen),
          builder: (_) => const HomeScreen(),
        );
    }
  }
}
