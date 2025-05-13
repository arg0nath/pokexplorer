import 'package:pokexplorer/features/type_selection/data/models/pokemon_type_dto.dart';

abstract interface class TypeSelectionLocalSourceInterface {
  Future<List<PokemonTypeDto>> getTypes();
}
