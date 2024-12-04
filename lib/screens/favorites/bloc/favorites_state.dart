part of 'favorites_bloc.dart';

enum UserFavoritesStatus {
  userFavoritesNotLoaded,
  loadingUserFavorites,

  userFavoritesLoaded,
  updatingFavorites,
  favoritesUpdated,

  notifyingForNoInternetError,
  readyToNotifyForNoInternet,
  navigatingToPokemonDetails,
  readyToNavigateToPokemonDetails,
  showDialogToRemovePokemon,
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
