part of 'user_favorites_bloc.dart';

sealed class UserFavoritesState extends Equatable {
  const UserFavoritesState();

  @override
  List<Object> get props => [];
}

final class LoadingUserFavorites extends UserFavoritesState {}

final class UserFavoritesLoaded extends UserFavoritesState {
  UserFavoritesLoaded(this.favorites) : favoriteNames = favorites.map((e) => e.name).toSet();

  final List<PokemonPreview> favorites;
  final Set<String> favoriteNames;

  @override
  List<Object> get props => [favorites, favoriteNames];
}

final class UpdatingFavoriteStatus extends UserFavoritesState {
  UpdatingFavoriteStatus(this.favorites) : favoriteNames = favorites.map((e) => e.name).toSet();

  final List<PokemonPreview> favorites;
  final Set<String> favoriteNames;

  @override
  List<Object> get props => [favorites, favoriteNames];
}

final class UserFavoritesError extends UserFavoritesState {
  const UserFavoritesError(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
