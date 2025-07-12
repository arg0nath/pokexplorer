import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/features/type_selection/domain/entities/pokemon_type.dart';

abstract interface class PokemonTypeRepository {
  const PokemonTypeRepository();

  ResultFuture<List<PokemonType>> getPokemonTypes();
  ResultFutureVoid selectPokemonType(String typeName);
  ResultFuture<String> getSelectedPokemonType();
}
