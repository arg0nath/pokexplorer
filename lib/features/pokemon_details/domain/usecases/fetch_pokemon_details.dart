import 'package:equatable/equatable.dart';
import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/config/usecase/usecase.dart';
import 'package:pokexplorer/features/pokemon_details/domain/entities/pokemon_details.dart';
import 'package:pokexplorer/features/pokemon_details/domain/repos/pokemon_details_repo.dart';

class FetchPokemonDetails extends UseCaseWithParams<PokemonDetails, FetchPokemonDetailsParams> {
  const FetchPokemonDetails(this._pokemonDetailsRepository);

  final PokemonDetailsRepository _pokemonDetailsRepository;

  @override
  ResultFuture<PokemonDetails> call(FetchPokemonDetailsParams params) async => _pokemonDetailsRepository.fetchPokemonDetails(params.name);
}

class FetchPokemonDetailsParams extends Equatable {
  const FetchPokemonDetailsParams({required this.name});

  final String name;

  @override
  List<Object?> get props => <Object?>[name];
}
