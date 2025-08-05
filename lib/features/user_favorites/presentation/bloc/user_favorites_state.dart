part of 'user_favorites_bloc.dart';

sealed class UserFavoritesState extends Equatable {
  const UserFavoritesState();

  @override
  List<Object> get props => [];
}

final class UserFavoritesInitial extends UserFavoritesState {}

final class UpdatingFavoriteStatus extends UserFavoritesState {}

final class FavoriteStatusUpdated extends UserFavoritesState {}

final class UserFavoritesFailed extends UserFavoritesState {
  const UserFavoritesFailed(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
