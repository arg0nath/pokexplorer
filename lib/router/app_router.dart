import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:pokexplorer/screens/type_selection/view/type_selection_screen.dart';

import '../src/utilities/front_end_utils.dart';
import '../screens/pokemon_details/view/pokemon_details_screen.dart';
import '../screens/type_details/view/type_details_screen.dart';
import '../screens/welcome/welcome.dart';
import '../src/models/app_models.dart' as app_models;
import '../src/variables/app_constants.dart' as app_const;

// #region // * Arguments

class PokemonDetailsScreenArguments {
  PokemonDetailsScreenArguments({required this.pokemon});

  final app_models.Pokemon pokemon;
}

class TypeDetailsScreenArguments {
  TypeDetailsScreenArguments({required this.typeName});

  final String typeName;
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
        return PageTransition<dynamic>(
            type: app_const.PAGE_TRANSITION_TYPE_FADE, settings: const RouteSettings(name: app_const.TYPE_DETAILS_SCREEN_PAGE_ROUTE_NAME), child: TypeDetailsScreen(typeName: args.typeName));
      case app_const.TYPE_SELECTION_SCREEN_PAGE_ROUTE_NAME:
        return PageTransition<dynamic>(
            type: app_const.PAGE_TRANSITION_TYPE_FADE, settings: const RouteSettings(name: app_const.TYPE_SELECTION_SCREEN_PAGE_ROUTE_NAME), child: const TypeSelectionScreen());
      case app_const.WELCOME_SCREEN_ROUTE_NAME:
        return PageTransition<dynamic>(type: app_const.PAGE_TRANSITION_TYPE_FADE, settings: const RouteSettings(name: app_const.WELCOME_SCREEN_ROUTE_NAME), child: const WelcomeScreen());
      case app_const.POKEMON_DETAILS_SCREEN_ROUTE_NAME:
        final PokemonDetailsScreenArguments args = settings.arguments! as PokemonDetailsScreenArguments;
        return PageTransition<dynamic>(
            type: app_const.PAGE_TRANSITION_TYPE_FADE, settings: const RouteSettings(name: app_const.POKEMON_DETAILS_SCREEN_ROUTE_NAME), child: PokemonDetailsScreen(pokemon: args.pokemon));
      default:
        return PageTransition<dynamic>(
            type: app_const.PAGE_TRANSITION_TYPE_FADE, settings: const RouteSettings(name: app_const.TYPE_SELECTION_SCREEN_PAGE_ROUTE_NAME), child: const TypeSelectionScreen());
    }
  }
}
