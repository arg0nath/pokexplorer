import 'dart:ui';

import 'package:pokexplorer/config/theme/app_palette.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/res/app_assets.dart';

String getIconForType(String typeName) {
  return '${AppAssets.imagesBasePath}/${typeName}_icon.png';
}

int getColorForType(String typeName) {
  // Map of type names to their associated colors
  const Map<String, Color> typeColorMap = <String, Color>{
    AppConst.fireTypeName: AppPalette.fire,
    AppConst.waterTypeName: AppPalette.water,
    AppConst.grassTypeName: AppPalette.grass,
    AppConst.electricTypeName: AppPalette.electric,
    AppConst.dragonTypeName: AppPalette.dragon,
    AppConst.psychicTypeName: AppPalette.psychic,
    AppConst.ghostTypeName: AppPalette.ghost,
    AppConst.darkTypeName: AppPalette.dark,
    AppConst.steelTypeName: AppPalette.steel,
    AppConst.fairyTypeName: AppPalette.fairy,
    AppConst.normalTypeName: AppPalette.normal,
    AppConst.fightingTypeName: AppPalette.fighting,
    AppConst.flyingTypeName: AppPalette.flying,
    AppConst.poisonTypeName: AppPalette.poison,
    AppConst.groundTypeName: AppPalette.ground,
    AppConst.rockTypeName: AppPalette.rock,
    AppConst.bugTypeName: AppPalette.bug,
    AppConst.iceTypeName: AppPalette.ice,
  };

  return typeColorMap[typeName]?.toARGB32() ?? 0xFFFFFFFF;
}

String getPokemonBaseImageById(int id) {
  return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
}

int extractPokemonPreviewId(String url) {
  final String id = url.split('/').where((String segment) => segment.isNotEmpty).last; // the last parameter of the url is the id
  final int resultId = int.tryParse(id) ?? AppConst.emptyInt;
  return resultId;
}
