part of 'user_favorites_bloc.dart';

sealed class UserFavoritesEvent extends Equatable {
  const UserFavoritesEvent();

  @override
  List<Object> get props => [];
}

final class LoadUserFavoritesEvent extends UserFavoritesEvent {}

final class AddToFavoritesEvent extends UserFavoritesEvent {
  const AddToFavoritesEvent(this.preview);

  final PokemonPreview preview;

  @override
  List<Object> get props => [preview];
}

final class RemoveFromFavoritesEvent extends UserFavoritesEvent {
  const RemoveFromFavoritesEvent(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}
