abstract class RoutePath {
  static const String typeResultsPage = '/${RouteName.typeResultsPageName}';
  static const String typeSelectionPage = '/${RouteName.typeSelectionPageName}';
  static const String pokemonDetailsPage = '/${RouteName.pokemonDetailsPageName}';
  static const String onBoardingPage = '/${RouteName.onBoardingPageName}';
  static const String userFavoritesPage = '/${RouteName.userFavoritesPageName}';
}

abstract class RouteName {
  static const String typeResultsPageName = 'type-results';
  static const String typeSelectionPageName = 'type-selection';
  static const String pokemonDetailsPageName = 'poke-details';
  static const String onBoardingPageName = 'on-boarding';
  static const String userFavoritesPageName = 'user-favorites';
}
