part of 'pokemon_details_bloc.dart';

enum PokemonDetailsStatus {
  pokemonDetailsNotLoaded,
  loadingPokemonDetails,

  pokemonDetailsLoaded,
  pokemonDetailsLoadFailed,
}

class PokemonDetailsState extends Equatable {
  const PokemonDetailsState({
    required this.pokemonDetailsStatus,
    this.errorMessage,
  });

  final PokemonDetailsStatus pokemonDetailsStatus;
  final String? errorMessage;

  @override
  List<Object?> get props => <Object?>[pokemonDetailsStatus, errorMessage];

  @override
  String toString() => 'pokemonDetailsStatus = $pokemonDetailsStatus\n';
}
