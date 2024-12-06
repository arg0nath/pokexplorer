// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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
const String HOME_SCREEN_PAGE_ROUTE_NAME = '/screens/home/view/home_screen';
const String TYPE_DETAILS_SCREEN_PAGE_ROUTE_NAME = '/screens/type_details/view/type_details_screen';
const String TYPE_SELECTION_SCREEN_PAGE_ROUTE_NAME = '/screens/type_selection/view/type_selection_screen';
const String POKEMON_DETAILS_SCREEN_ROUTE_NAME = 'screens/pokemon_details/view/details_screen';
const String WELCOME_SCREEN_ROUTE_NAME = 'screens/welcome/view/welcome_screen';
const String FAVORITES_ROUTE_NAME = 'screens/welcome/view/favorites_screen';

const String BOTTOM_BAR_PAGE_TYPE_SELECTION_SCREEN = 'TypeSelectionScreen';
const String BOTTOM_BAR_PAGE_USER_FAVORITES_SCREEN = 'UserFavoritesScreen';

const PageTransitionType PAGE_TRANSITION_TYPE_FADE = PageTransitionType.fade;
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
const Color NETWORK_IMAGE_PLACEHOLDER_COLOR = WHITE_TOTAL;
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

const Color GRADIENT_BASE = Color(0xFFF6EFE9);
const Color GRADIENT_DEFAULT = Color(0xFFFACCCC);
const Color FIRE_COLOR = Color(0xffef7374);
const Color WATER_COLOR = Color(0xff74acf5);
const Color GRASS_COLOR = Color(0xff82c274);
const Color ELECTRIC_COLOR = Color(0xfffcd659);
const Color DRAGON_COLOR = Color(0xff8d98ec);
const Color PSYCHIC_COLOR = Color(0xfff584a8);
const Color GHOST_COLOR = Color(0xffa284a2);
const Color DARK_COLOR = Color(0xff998b8c);
const Color STEEL_COLOR = Color(0xff98c2d1);
const Color FAIRY_COLOR = Color(0xfff5a2f5);
const Color NORMAL_COLOR = Color(0xffc1c2c1);
const Color FIGHTING_COLOR = Color(0xffffac59);
const Color FLYING_COLOR = Color(0xffadd2f5);
const Color POISON_COLOR = Color(0xffb884dd);
const Color GROUND_COLOR = Color(0xffb88e6f);
const Color ROCK_COLOR = Color(0xffcbc7ad);
const Color BUG_COLOR = Color(0xffb8c26a);
const Color ICE_COLOR = Color(0xff81dff7);

const Color WHITE_TOTAL = Color(0xffffffff);
const Color BLACK_TOTAL = Color(0xff000000);

const Color WHITE_IOS = Color(0xfff5f5f7); // i named it like this because apple use slight different white for better ui-contrast
const Color BLACK_IOS = Color(0xff313132); // i named it like this because apple use slight different black for better ui-contrast
const Color GREY = Color(0xFF979797);

//Text Styling

const Color PRIMARY_TEXT_COLOR = Color(0xff4e4e4e);
const Color SECONDARY_TEXT_COLOR = Color(0xFF9E9E9E);
const Color TOAST_BACKGROUND_COLOR = Colors.blueGrey;
const double DIALOG_PADDING = 16.0;
const double DIALOG_BORDER_WIDTH = 4.0;
const Color DIALOG_BORDER_COLOR = WHITE_TOTAL;

//dot scoll
const Color PAGE_INDICATOR_INACTIVATE_DOT_COLOR = Color(0xFFBDBDBD);
const Color PAGE_INDICATOR_ACTIVATE_DOT_COLOR = Colors.red;

const SCAFFOLD_BACKGROUND_DARK = Color(0xff212121);
const SCAFFOLD_BACKGROUND_LIGHT = WHITE_IOS;
const SHADOW_COLOR_LIGHT = Color(0xFFB4B4B4);
const SHADOW_COLOR_DARK = Color.fromARGB(255, 90, 90, 90);

const APPBAR_BACKGROUND_DARK = Color(0xff212121);
const APPBAR_BACKGROUND_LIGHT = WHITE_IOS;

const CARD_LIGHT = Color(0xCCFFFFFF);
const CARD_DARK = Color(0xCC505050);

const USER_FAVORITES_POP_MENU_CLEAR_ALL_VALUE = 0;

const double EXPANDED_BAR_HEIGHT = 200;
const double COLLAPSED_BAR_HEIGHT = 130;

//gradients
const Color BRIGHTER_GREY = Color(0xFFC5C5C5);
const Color VIBRANT_TURQUOISE = Color(0xFF1CD5C6);
const Color MORE_VIBRANT_TURQUOISE = Color(0xff28c9e1);
const Color BLUEISH = Color.fromARGB(255, 40, 114, 225);
const Color LIGHTER_GREEN = Color(0xFF74B577);
const Color DARKER_GREEN = Color(0xFF66CC6B);
const Color LIGHT_RED = Color(0xa8fe6464);
const Color BRIGHT_RED = Color(0xFFFF5555);

const List<Color> GRADIENT_TURQUOISE = <Color>[VIBRANT_TURQUOISE, MORE_VIBRANT_TURQUOISE];
const List<Color> GRADIENT_GREY = <Color>[BRIGHTER_GREY, BRIGHTER_GREY];
const List<Color> GRADIENT_RED = <Color>[BRIGHT_RED, LIGHT_RED];
const List<Color> GRADIENT_GREEN = <Color>[LIGHTER_GREEN, DARKER_GREEN];

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
