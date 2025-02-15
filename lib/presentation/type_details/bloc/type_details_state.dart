part of 'type_details_bloc.dart';

enum TypeDetailsStatus {
  typeDetailsNotLoaded,

  loadingPokemons,

  pokemonsLoaded,

  loadingMorePokemons,
  morePokemonsLoaded,
  morePokemonsLoadedFailed,

  navigatingToPokemonDetails,
  readyToNavigateToPokemonDetails,
  errorNavigateToPokemonDetailsFailed,

  notifyingForNoInternetError,
  readyToNotifyForNoInternet,

  searchingPokemon,
  pokemonSearched,
  cancelingSearch,
  searchCancelled,

  refreshingPokemonTypeDetailsRefreshed,
  pokemonTypeDetailsRefreshed,
  updatingRelationInTypeDetails,
  relationInTypeDetailsUpdated,

  updatingFavoritesTypeDetails,
  favoritesTypeDetailsUpdated,

  exitingTypeDetails,
  typeDetailsExited,
}

class TypeDetailsState extends Equatable {
  const TypeDetailsState({
    required this.typeDetailsStatus,
    this.searchedPokemonPreviewList = const [],
  });

  final TypeDetailsStatus typeDetailsStatus;
  final List<PokemonPreview> searchedPokemonPreviewList;

  @override
  List<Object?> get props => <Object?>[typeDetailsStatus, searchedPokemonPreviewList];
}
