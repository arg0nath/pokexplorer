import 'package:pokexplorer/core/constants/app_const.dart';
import 'package:pokexplorer/features/type_selection/data/models/pokemon_type_dto.dart';

abstract interface class TypeSelectionLocalSourceInterface {
  Future<List<PokemonTypeDto>> getTypes();
}

class TypeSelectionLocalSourceImpl implements TypeSelectionLocalSourceInterface {
  @override
  Future<List<PokemonTypeDto>> getTypes() async {
    const List<PokemonTypeDto> availableTypes = <PokemonTypeDto>[
      PokemonTypeDto(name: FIRE_TYPE_NAME, icon: FIRE_ICON),
      PokemonTypeDto(name: WATER_TYPE_NAME, icon: WATER_ICON),
      PokemonTypeDto(name: GRASS_TYPE_NAME, icon: GRASS_ICON),
      PokemonTypeDto(name: ELECTRIC_TYPE_NAME, icon: ELECTRIC_ICON),
      PokemonTypeDto(name: DRAGON_TYPE_NAME, icon: DRAGON_ICON),
      PokemonTypeDto(name: PSYCHIC_TYPE_NAME, icon: PSYCHIC_ICON),
      PokemonTypeDto(name: GHOST_TYPE_NAME, icon: GHOST_ICON),
      PokemonTypeDto(name: DARK_TYPE_NAME, icon: DARK_ICON),
      PokemonTypeDto(name: STEEL_TYPE_NAME, icon: STEEL_ICON),
      PokemonTypeDto(name: FAIRY_TYPE_NAME, icon: FAIRY_ICON),
    ];

    return Future<List<PokemonTypeDto>>.value(availableTypes);
  }
}
