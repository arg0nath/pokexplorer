part of 'type_details_bloc.dart';

enum TypeDetailsStatus {
  typeDetailsNotLoaded,

  loadingPokemons,

  pokemonsLoaded,

  loadingMorePokemons,
  morePokemonsLoaded,
  morePokemonsLoadedFailed,

  navigatingToPokemonDetails,
  navigatingToPokemonDetailsFailed,
  readyToNavigateToPokemonDetails,

  searchingPokemon,
  pokemonSearched,
  cancelingSearch,
  searchCancelled,

  exitingTypeDetails,
  typeDetailsExited,
}

class TypeDetailsState extends Equatable {
  const TypeDetailsState({
    required this.typeDetailsStatus,
    this.errorMessage,
    this.searchedPokemonPreviewList = const [],
  });

  final TypeDetailsStatus typeDetailsStatus;
  final List<app_models.PokemonPreview> searchedPokemonPreviewList;
  final String? errorMessage;

  @override
  List<Object?> get props => <Object?>[typeDetailsStatus, searchedPokemonPreviewList, errorMessage];
}
