part of 'favorites_bloc.dart';

enum UserFavoritesStatus {
  userFavoritesNotLoaded,
  loadingUserFavorites,

  refreshingFavorites,
  userFavoritesRefreshed,

  userFavoritesLoaded,
  updatingFavorites,
  favoritesUpdated,

  notifyingForNoInternetFavoritesError,
  noInternetFailedFavorites,
  navigatingToPokemonDetails,
  readyToNavigateToPokemonDetails,
  showingDialogToRemovePokemon,
  showDialogToRemovePokemon,
  removingPokemon,
  pokemonRemoved,

  showingDialogToDeleteAll,
  showDialogToDeleteAll,
  deletingAllPokemon,
  allPokemonDeleted,

  navigateToDetailsFromFavoritesFailed
}

class UserFavoritesState extends Equatable {
  const UserFavoritesState({
    required this.userFavoritesStatus,
  });

  final UserFavoritesStatus userFavoritesStatus;

  @override
  List<Object?> get props => <Object?>[userFavoritesStatus];

  @override
  String toString() => 'favoritesStatus = $userFavoritesStatus\n';
}
