import 'package:pokexplorer/core/constants/app_const.dart';
import 'package:pokexplorer/features/type_selection/data/models/pokemon_type_dto.dart';

abstract interface class TypeSelectionLocalSource {
  Future<List<PokemonTypeDto>> fetchPokemonTypes();
}

class TypeSelectionLocalSourceImpl implements TypeSelectionLocalSource {
  List<PokemonTypeDto> availableTypes = <PokemonTypeDto>[
    const PokemonTypeDto(name: FIRE_TYPE_NAME, icon: FIRE_ICON),
    const PokemonTypeDto(name: WATER_TYPE_NAME, icon: WATER_ICON),
    const PokemonTypeDto(name: GRASS_TYPE_NAME, icon: GRASS_ICON),
    const PokemonTypeDto(name: ELECTRIC_TYPE_NAME, icon: ELECTRIC_ICON),
    const PokemonTypeDto(name: DRAGON_TYPE_NAME, icon: DRAGON_ICON),
    const PokemonTypeDto(name: PSYCHIC_TYPE_NAME, icon: PSYCHIC_ICON),
    const PokemonTypeDto(name: GHOST_TYPE_NAME, icon: GHOST_ICON),
    const PokemonTypeDto(name: DARK_TYPE_NAME, icon: DARK_ICON),
    const PokemonTypeDto(name: STEEL_TYPE_NAME, icon: STEEL_ICON),
    const PokemonTypeDto(name: FAIRY_TYPE_NAME, icon: FAIRY_ICON),
  ];

  @override
  Future<List<PokemonTypeDto>> fetchPokemonTypes() async {
    return Future<List<PokemonTypeDto>>.value(availableTypes);
  }
}
