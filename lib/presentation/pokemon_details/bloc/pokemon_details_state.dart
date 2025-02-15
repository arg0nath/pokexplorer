part of 'pokemon_details_bloc.dart';

enum PokemonDetailsStatus {
  pokemonDetailsNotLoaded,
  loadingPokemonDetails,
  pokemonDetailsLoaded,

  updatingPokemoPreviewRelation,
  pokemoPreviewRelationUpdated,

  exitingPokemonDetails,
  readyToExitPokemonDetails,
}

class PokemonDetailsState extends Equatable {
  const PokemonDetailsState({
    required this.pokemonDetailsStatus,
  });

  final PokemonDetailsStatus pokemonDetailsStatus;

  @override
  List<Object?> get props => <Object?>[pokemonDetailsStatus];

  @override
  String toString() => 'pokemonDetailsStatus = $pokemonDetailsStatus\n';
}
