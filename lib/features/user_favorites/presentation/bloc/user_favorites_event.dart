part of 'user_favorites_bloc.dart';

sealed class UserFavoritesEvent extends Equatable {
  const UserFavoritesEvent();

  @override
  List<Object> get props => [];
}

final class LoadUserFavorites extends UserFavoritesEvent {}

final class AddToFavorites extends UserFavoritesEvent {
  const AddToFavorites(this.preview);

  final PokemonPreview preview;

  @override
  List<Object> get props => [preview];
}

final class RemoveFromFavorites extends UserFavoritesEvent {
  const RemoveFromFavorites(this.pokemonId);

  final int pokemonId;

  @override
  List<Object> get props => [pokemonId];
}
