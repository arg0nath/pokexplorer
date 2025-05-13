// Method to get color based on Pokemon type
import 'dart:ui';

import 'package:pokexplorer/core/constants/app_const.dart';
import 'package:pokexplorer/core/theme/app_palette.dart';

Color getTypeColor(String name) {
  switch (name.toLowerCase()) {
    case FIRE_TYPE_NAME:
      return AppPalette.fire;
    case WATER_TYPE_NAME:
      return AppPalette.water;
    case GRASS_TYPE_NAME:
      return AppPalette.grass;
    case ELECTRIC_TYPE_NAME:
      return AppPalette.electric;
    case DRAGON_TYPE_NAME:
      return AppPalette.dragon;
    case PSYCHIC_TYPE_NAME:
      return AppPalette.psychic;
    case GHOST_TYPE_NAME:
      return AppPalette.ghost;
    case DARK_TYPE_NAME:
      return AppPalette.dark;
    case STEEL_TYPE_NAME:
      return AppPalette.steel;
    case FAIRY_TYPE_NAME:
      return AppPalette.fairy;
    case NORMAL_TYPE_NAME:
      return AppPalette.normal;
    case FIGHTING_TYPE_NAME:
      return AppPalette.fighting;
    case FLYING_TYPE_NAME:
      return AppPalette.flying;
    case POISON_TYPE_NAME:
      return AppPalette.poison;
    case GROUND_TYPE_NAME:
      return AppPalette.ground;
    case ROCK_TYPE_NAME:
      return AppPalette.rock;
    case BUG_TYPE_NAME:
      return AppPalette.bug;
    case ICE_TYPE_NAME:
      return AppPalette.ice;
    default:
      return AppPalette.gradientBaseLight; // Default color if no match
  }
}
