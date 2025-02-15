import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pokexplorer/presentation/favorites/view/favorites_screen.dart';
import 'package:pokexplorer/presentation/home/view/home_screen.dart';
import 'package:pokexplorer/presentation/type_selection/view/type_selection_screen.dart';

import '../core/models/app_models.dart' as app_models;
import '../core/utilities/front_end_utils.dart';
import '../core/variables/app_constants.dart' as app_const;
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

/// Class that implements a callback for managing page transition when the app is navigated to a named route. (+a smooth fade animation for each screen)
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case app_const.TYPE_DETAILS_SCREEN_PAGE_ROUTE_NAME:
        final TypeDetailsScreenArguments args = settings.arguments! as TypeDetailsScreenArguments;
        return MaterialPageRoute(builder: (context) => TypeDetailsScreen(typeDetails: args.typeDetails));
      //return PageTransition<dynamic>(type: app_const.PAGE_TRANSITION_TYPE_FADE, settings: const RouteSettings(name: app_const.TYPE_DETAILS_SCREEN_PAGE_ROUTE_NAME), child: TypeDetailsScreen(typeDetails: args.typeDetails));
      case app_const.TYPE_SELECTION_SCREEN_PAGE_ROUTE_NAME:
        return PageTransition<dynamic>(
            type: app_const.PAGE_TRANSITION_TYPE_FADE, settings: const RouteSettings(name: app_const.TYPE_SELECTION_SCREEN_PAGE_ROUTE_NAME), child: const TypeSelectionScreen());
      case app_const.HOME_SCREEN_PAGE_ROUTE_NAME:
        return PageTransition<dynamic>(type: app_const.PAGE_TRANSITION_TYPE_FADE, settings: const RouteSettings(name: app_const.HOME_SCREEN_PAGE_ROUTE_NAME), child: const HomeScreen());
      case app_const.FAVORITES_ROUTE_NAME:
        return PageTransition<dynamic>(type: app_const.PAGE_TRANSITION_TYPE_FADE, settings: const RouteSettings(name: app_const.FAVORITES_ROUTE_NAME), child: const FavoritesScreen());
      case app_const.WELCOME_SCREEN_ROUTE_NAME:
        return PageTransition<dynamic>(type: app_const.PAGE_TRANSITION_TYPE_FADE, settings: const RouteSettings(name: app_const.WELCOME_SCREEN_ROUTE_NAME), child: const WelcomeScreen());
      case app_const.POKEMON_DETAILS_SCREEN_ROUTE_NAME:
        final PokemonDetailsScreenArguments args = settings.arguments! as PokemonDetailsScreenArguments;
        return MaterialPageRoute(builder: (context) => PokemonDetailsScreen(pokemon: args.pokemon, selectedTypeName: args.selectedTypeName));
      //return PageTransition<dynamic>(type: app_const.PAGE_TRANSITION_TYPE_FADE,settings: const RouteSettings(name: app_const.POKEMON_DETAILS_SCREEN_ROUTE_NAME),child: PokemonDetailsScreen(pokemon: args.pokemon,selectedTypeName: args.selectedTypeName,));
      default:
        return PageTransition<dynamic>(type: app_const.PAGE_TRANSITION_TYPE_FADE, settings: const RouteSettings(name: app_const.HOME_SCREEN_PAGE_ROUTE_NAME), child: const HomeScreen());
    }
  }
}
