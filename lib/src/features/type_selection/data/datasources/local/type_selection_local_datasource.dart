import 'package:pokexplorer/src/features/type_selection/data/models/pokemon_type_dto.dart';

abstract class TypeSelectionLocalDataSource {
  const TypeSelectionLocalDataSource();

  Future<List<PokemonTypeDto>> getPokemonTypes();
}

class TypeSelectionLocalDataSourceImpl implements TypeSelectionLocalDataSource {
  const TypeSelectionLocalDataSourceImpl();

  @override
  Future<List<PokemonTypeDto>> getPokemonTypes() async {
    // Simulate fetching data from local storage
    final types = [
      PokemonTypeDto.fromTypeName('fire'),
      PokemonTypeDto.fromTypeName('water'),
      PokemonTypeDto.fromTypeName('grass'),
      PokemonTypeDto.fromTypeName('electric'),
      PokemonTypeDto.fromTypeName('dragon'),
      PokemonTypeDto.fromTypeName('psychic'),
      PokemonTypeDto.fromTypeName('ghost'),
      PokemonTypeDto.fromTypeName('dark'),
      PokemonTypeDto.fromTypeName('steel'),
      PokemonTypeDto.fromTypeName('fairy'),
      PokemonTypeDto.fromTypeName('normal'),
      PokemonTypeDto.fromTypeName('fighting'),
      PokemonTypeDto.fromTypeName('flying'),
      PokemonTypeDto.fromTypeName('poison'),
      PokemonTypeDto.fromTypeName('ground'),
      PokemonTypeDto.fromTypeName('rock'),
      PokemonTypeDto.fromTypeName('bug'),
      PokemonTypeDto.fromTypeName('ice'),
    ];
    final List<PokemonTypeDto> result = types.map((type) => PokemonTypeDto.fromJson(type.toJson())).toList();
    return Future<List<PokemonTypeDto>>.value(result);
  }
}
