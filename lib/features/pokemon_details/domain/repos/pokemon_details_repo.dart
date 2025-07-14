import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/features/pokemon_details/domain/entities/pokemon_details.dart';

abstract interface class PokemonDetailsRepository {
  const PokemonDetailsRepository();

  ResultFuture<PokemonDetails> fetchPokemonDetails(String name);
}
