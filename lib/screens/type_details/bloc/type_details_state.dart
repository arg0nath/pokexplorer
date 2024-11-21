part of 'type_details_bloc.dart';

enum TypeDetailsStatus {
  typeDetailsNotLoaded,

  loadingPokemons,
  loadingOnePokemon,
  onePokemonLoaded,
  pokemonsLoaded,
  pokemonsLoadedFailed,

  loadingMorePokemons,
  morePokemonsLoaded,

  navigatingToPokemonDetails,
  readyToNavigateToPokemonDetails,

  searchingPokemon,
  pokemonSearched,
  cancelingSearch,
  searchCancelled,

  exitingTypeDetails,
  typeDetailsExited,
}

class TypeDetailsState extends Equatable {
  const TypeDetailsState({required this.typeDetailsStatus});

  final TypeDetailsStatus typeDetailsStatus;

  @override
  List<Object> get props => <Object>[typeDetailsStatus];
}
