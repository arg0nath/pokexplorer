import 'package:pokexplorer/core/constants/app_const.dart';
import 'package:pokexplorer/features/type_selection/data/models/pokemon_type_dto.dart';
import 'package:pokexplorer/features/type_selection/data/sources/local/interface/type_selection_local_data_source_interface.dart';

class TypeSelectionLocalSourceImpl implements TypeSelectionLocalSourceInterface {
  @override
  Future<List<PokemonTypeDto>> getTypes() async {
    // TODO(database): implement sqflite database to save them.
    final List<PokemonTypeDto> list = <PokemonTypeDto>[
      PokemonTypeDto(name: FIRE_TYPE_NAME, icon: FIRE_ICON, isSelected: false),
      PokemonTypeDto(name: WATER_TYPE_NAME, icon: WATER_ICON, isSelected: false),
      PokemonTypeDto(name: GRASS_TYPE_NAME, icon: GRASS_ICON, isSelected: false),
      PokemonTypeDto(name: ELECTRIC_TYPE_NAME, icon: ELECTRIC_ICON, isSelected: false),
      PokemonTypeDto(name: DRAGON_TYPE_NAME, icon: DRAGON_ICON, isSelected: false),
      PokemonTypeDto(name: PSYCHIC_TYPE_NAME, icon: PSYCHIC_ICON, isSelected: false),
      PokemonTypeDto(name: GHOST_TYPE_NAME, icon: GHOST_ICON, isSelected: false),
      PokemonTypeDto(name: DARK_TYPE_NAME, icon: DARK_ICON, isSelected: false),
      PokemonTypeDto(name: STEEL_TYPE_NAME, icon: STEEL_ICON, isSelected: false),
      PokemonTypeDto(name: FAIRY_TYPE_NAME, icon: FAIRY_ICON, isSelected: false),
    ];

    return Future<List<PokemonTypeDto>>.value(list);
  }
}
