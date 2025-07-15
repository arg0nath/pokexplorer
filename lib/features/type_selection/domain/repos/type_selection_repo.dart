import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/shared/entities/pokemon_type.dart';

abstract interface class TypeSelectionRepository {
  const TypeSelectionRepository();

  ResultFuture<List<PokemonType>> getPokemonTypes();
  ResultFutureVoid selectPokemonType(String typeName);
  ResultFuture<String> getSelectedPokemonType();
}
