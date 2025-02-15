part of 'favorites_bloc.dart';

abstract class UserFavoritesEvent extends Equatable {
  const UserFavoritesEvent();
}

class LoadFavoritesEvent extends UserFavoritesEvent {
  const LoadFavoritesEvent();

  @override
  List<Object?> get props => <Object>[];
}

class RefreshFavoritesEvent extends UserFavoritesEvent {
  const RefreshFavoritesEvent();

  @override
  List<Object?> get props => <Object>[];
}

class AddPokemonPreviewToFavoritesEvent extends UserFavoritesEvent {
  const AddPokemonPreviewToFavoritesEvent({required this.pokemonPreview});

  final app_models.PokemonPreview pokemonPreview;

  @override
  List<Object?> get props => <Object>[pokemonPreview];
}

class ShowDialogToRemoveFavoriteEvent extends UserFavoritesEvent {
  const ShowDialogToRemoveFavoriteEvent({required this.pokemonPreview});

  final app_models.PokemonPreview pokemonPreview;

  @override
  List<Object?> get props => <Object>[pokemonPreview];
}

class ShowDialogToDeleteAllEvent extends UserFavoritesEvent {
  const ShowDialogToDeleteAllEvent();

  @override
  List<Object?> get props => <Object>[];
}

class RemovePokemonPreviewFromFavoritesEvent extends UserFavoritesEvent {
  const RemovePokemonPreviewFromFavoritesEvent({required this.pokemonPreview});

  final app_models.PokemonPreview pokemonPreview;

  @override
  List<Object?> get props => <Object>[pokemonPreview];
}

class DeleteAllFavoritesEvent extends UserFavoritesEvent {
  const DeleteAllFavoritesEvent();

  @override
  List<Object?> get props => <Object>[];
}

class NavigateToDetailsFromFavoritesEvent extends UserFavoritesEvent {
  const NavigateToDetailsFromFavoritesEvent({required this.pokemonPreview});

  final app_models.PokemonPreview pokemonPreview;

  @override
  List<Object> get props => <Object>[pokemonPreview];
}
