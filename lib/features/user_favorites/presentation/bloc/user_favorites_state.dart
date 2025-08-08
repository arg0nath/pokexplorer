part of 'user_favorites_bloc.dart';

sealed class UserFavoritesState extends Equatable {
  const UserFavoritesState();

  @override
  List<Object> get props => [];
}

final class UserFavoritesInitial extends UserFavoritesState {}

final class LoadingUserFavorites extends UserFavoritesState {}

final class UserFavoritesLoaded extends UserFavoritesState {
  const UserFavoritesLoaded(this.favorites);

  final List<PokemonPreview> favorites;

  @override
  List<Object> get props => [favorites];
}

final class UpdatingFavoriteStatus extends UserFavoritesState {}

final class FavoriteStatusUpdated extends UserFavoritesState {
  const FavoriteStatusUpdated(this.favorites);

  final List<PokemonPreview> favorites;

  @override
  List<Object> get props => [favorites];
}

final class UserFavoritesError extends UserFavoritesState {
  const UserFavoritesError(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
