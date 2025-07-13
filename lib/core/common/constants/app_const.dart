import 'package:flutter/material.dart';

class AppConst {
  AppConst._(); // Prevent instantiation
  // #region // * Debug Stuff
  static const bool showLog = true;
  static const int logInfo = 0;
  static const int logWarning = 1;
  static const int logError = 2;
  static const int logWtf = 3; // :P
  static const String logResetColor = '\u001b[0m';
  static const String logErrorColor = '\u001b[31m';
  static const String logWarningColor = '\u001b[32m';
  static const String logWtfColor = '\u001b[36;1m';
// #endregion

  static const String mainFontFamily = 'lato';
  static const String appPackage = 'com.vamakris.pokexplorer';
  static const String appName = 'Pokéxplorer';
  static const String pokeApiUrl = 'https://pokeapi.co/api/v2/';
  static const int apiStatusOk = 200;

  static const int emptyInt = 0;
  static const double emptyDouble = 0.0;
  static const String emptyGuid = '00000000-0000-0000-0000-000000000000';
  static const String emptyString = '';

//appbar delegate stuff
  static const double typeDetailsAppBarDelegateMaxExtend = 330;
  static const double typeDetailsAppBarDelegateMinExtend = 180;
  static const double pokemonDetailsAppBarDelegateMaxExtend = 280;
  static const double pokemonDetailsAppBarDelegateMinExtend = 200;

//* SCROLLBAR CONSTANTS
  static const Radius scrollbarRadius = Radius.circular(10);
  static const double scrollbarThickness = 3.0;
  static const Color scrollbarColor = Color(0xFFC5C5C5);

//customNetworkImage customization
  static const double networkImageBorderRadius = 80.0;
  static const double networkImageNoBorderRadius = 0.0;
  static const double networkImagePlaceholderWidth = 1.0;

//welcome
  static const double welcomeScreenCarouselBlurRadius = 7;
  static const double welcomeScreenCarouselSpreadRadius = 6;

//lazy load stuff
  static const int typeDetailsPokemonPageSize = 10;
  static const String fireTypeName = 'fire';
  static const String waterTypeName = 'water';
  static const String grassTypeName = 'grass';
  static const String electricTypeName = 'electric';
  static const String dragonTypeName = 'dragon';
  static const String psychicTypeName = 'psychic';
  static const String ghostTypeName = 'ghost';
  static const String darkTypeName = 'dark';
  static const String steelTypeName = 'steel';
  static const String fairyTypeName = 'fairy';
  static const String normalTypeName = 'normal';
  static const String fightingTypeName = 'fighting';
  static const String flyingTypeName = 'flying';
  static const String poisonTypeName = 'poison';
  static const String groundTypeName = 'ground';
  static const String rockTypeName = 'rock';
  static const String bugTypeName = 'bug';
  static const String iceTypeName = 'ice';

  static const double dialogPadding = 16;
  static const double circularRadius = 20;
  static const double dialogBorderWidth = 1;

//dot scoll

  static const int userFavoritesPopMenuClearAllValue = 0;

  static const double expandedBarHeight = 200;
  static const double collapsedBarHeight = 130;

// #region // * App Preferences
  static const String prefsSelectedTypeName = 'selected_type_name';
  static const String prefsSelectedLocale = 'selected_locale';
  static const String prefsInitBoot = 'init_boot';
  static const String prefsIsDarkMode = 'is_dark_mode';
// #endregion
}
