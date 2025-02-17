// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

// #region // * Debug Stuff
const bool SHOW_LOG = true;
const int LOG_INFO = 0;
const int LOG_WARNING = 1;
const int LOG_ERROR = 2;
const int LOG_WTF = 3; // :P
const String LOG_RESET_COLOR = '\u001b[0m';
const String LOG_ERROR_COLOR = '\u001b[31m';
const String LOG_WARNING_COLOR = '\u001b[32m';
const String LOG_WTF_COLOR = '\u001b[36;1m';
// #endregion

const String MAIN_FONT_FAMILY = 'lato';
const String APP_PACKAGE = 'com.vamakris.pokexplorer';
const String APP_NAME = 'Pokéxplorer';
const String POKE_API = 'https://pokeapi.co/api/v2/';
const int API_STATUS_OK = 200;

const String BOTTOM_BAR_PAGE_TYPE_SELECTION_SCREEN = 'TypeSelectionScreen';
const String BOTTOM_BAR_PAGE_USER_FAVORITES_SCREEN = 'UserFavoritesScreen';

const int EMPTY_INT = -1;
const int EMPTY_INT_ZERO = 0;
const double EMPTY_DOUBLE = -1.0;
const double EMPTY_DOUBLE_ZERO = 0.0;
const String EMPTY_GUID = '00000000-0000-0000-0000-000000000000';
const String EMPTY_STRING = '';

//appbar delegate stuff
const double TYPE_DETAILS_APP_BAR_DELEGATE_MAX_EXTEND = 330;
const double TYPE_DETAILS_APP_BAR_DELEGATE_MIN_EXTEND = 180;

const double POKEMON_DETAILS_APP_BAR_DELEGATE_MAX_EXTEND = 280;
const double POKEMON_DETAILS_APP_BAR_DELEGATE_MIN_EXTEND = 200;

//* SCROLLBAR CONSTANTS
const Radius SCROLLBAR_RADIUS = Radius.circular(10);
const double SCROLLBAR_THICKNESS = 3.0;
const Color SCROLLBAR_COLOR = Color(0xFFC5C5C5);

//customNetworkImage customization
const double NETWORK_IMAGE_BORDER_RADIUS = 80.0;
const double NETWORK_IMAGE_NO_BORDER_RADIUS = 0.0;
const double NETWORK_IMAGE_PLACEHOLDER_WIDTH = 1.0;

//welcome
const double WELCOME_SCREEN_CAROUSEL_BLUR_RADIUS = 7;
const double WELCOME_SCREEN_CAROUSEL_SPREAD_RADIUS = 6;

//lazy load stuff
// ignore: non_constant_identifier_names
int TYPE_DETAILS_POKEMON_PAGE_SIZE = 10;

const String FIRE_TYPE_NAME = 'fire';
const String WATER_TYPE_NAME = 'water';
const String GRASS_TYPE_NAME = 'grass';
const String ELECTRIC_TYPE_NAME = 'electric';
const String DRAGON_TYPE_NAME = 'dragon';
const String PSYCHIC_TYPE_NAME = 'psychic';
const String GHOST_TYPE_NAME = 'ghost';
const String DARK_TYPE_NAME = 'dark';
const String STEEL_TYPE_NAME = 'steel';
const String FAIRY_TYPE_NAME = 'fairy';

const String NORMAL_TYPE_NAME = 'normal';
const String FIGHTING_TYPE_NAME = 'fighting';
const String FLYING_TYPE_NAME = 'flying';
const String POISON_TYPE_NAME = 'poison';
const String GROUND_TYPE_NAME = 'ground';
const String ROCK_TYPE_NAME = 'rock';
const String BUG_TYPE_NAME = 'bug';
const String ICE_TYPE_NAME = 'ice';

const double CIRCULAR_RADIUS = 20;
const double DIALOG_PADDING = 16;
const double DIALOG_BORDER_WIDTH = 1;

//dot scoll

const USER_FAVORITES_POP_MENU_CLEAR_ALL_VALUE = 0;

const double EXPANDED_BAR_HEIGHT = 200;
const double COLLAPSED_BAR_HEIGHT = 130;

//assets stuff

const String FIRE_ICON = 'assets/images/fire_icon.png';
const String WATER_ICON = 'assets/images/water_icon.png';
const String GRASS_ICON = 'assets/images/grass_icon.png';
const String ELECTRIC_ICON = 'assets/images/electric_icon.png';
const String DRAGON_ICON = 'assets/images/dragon_icon.png';
const String PSYCHIC_ICON = 'assets/images/psychic_icon.png';
const String GHOST_ICON = 'assets/images/ghost_icon.png';
const String DARK_ICON = 'assets/images/dark_icon.png';
const String STEEL_ICON = 'assets/images/steel_icon.png';
const String FAIRY_ICON = 'assets/images/fairy_icon.png';

const String NORMAL_ICON = 'assets/images/normal_icon.png';
const String FIGHTING_ICON = 'assets/images/fighting_icon.png';
const String FLYING_ICON = 'assets/images/flying_icon.png';
const String POISON_ICON = 'assets/images/poison_icon.png';
const String GROUND_ICON = 'assets/images/ground_icon.png';
const String ROCK_ICON = 'assets/images/rock_icon.png';
const String BUG_ICON = 'assets/images/bug_icon.png';
const String ICE_ICON = 'assets/images/ice_icon.png';

const String POKEDEX_PNG = 'assets/images/pokedex.png';

const String POKEBALL_PNG = 'assets/images/pokeball.png';
const String EMPTY_POKEBALL_PNG = 'assets/images/emptyPokeball.png';
const String POKEBALL_OUTLINED_PNG = 'assets/images/pokeball_outlined.png';
const String POKEXPLORER_LOGO_PNG = 'assets/images/pokexplorer_logo.png';
const String POKEMON_LOGO_SVG = 'assets/svgs/official_pokemon_logo.svg';
const String POKEMON_CUSTOM_PHRASE = 'assets/images/gonnasearch.png';

const String LOADING_POKEBALL_LOTTIE = 'assets/lottieFiles/pokeball.json';

// #region // * App Preferences
const String PREFS_SELECTED_TYPE_NAME = 'selected_type_name';
const String PREFS_SELECTED_LOCALE = 'selected_locale';
const String PREFS_INIT_BOOT = 'init_boot';
const String PREFS_IS_DARK_MODE = 'is_dark_mode';
// #endregion
