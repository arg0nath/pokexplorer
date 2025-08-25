abstract class RoutePath {
  static const String rootPage = '/';
  static const String typeDetailsPage = '/${RouteName.typeDetailsPageName}';
  static const String typeSelectionPage = '/${RouteName.typeSelectionPageName}';
  static const String pokemonDetailsPage = '/${RouteName.pokemonDetailsPageName}';
  static const String onBoardingPage = '/${RouteName.onBoardingPageName}';
  static const String userFavoritesPage = '/${RouteName.userFavoritesPageName}';
  static const String debugPage = '/${RouteName.debugPageName}';
  static const String settingsPage = '/${RouteName.settingsPageName}';
}

abstract class RouteName {
  static const String typeDetailsPageName = 'type-details';
  static const String typeSelectionPageName = 'type-selection';
  static const String pokemonDetailsPageName = 'poke-details';
  static const String onBoardingPageName = 'on-boarding';
  static const String userFavoritesPageName = 'user-favorites';
  static const String debugPageName = 'debug';
  static const String settingsPageName = 'settings';
}
