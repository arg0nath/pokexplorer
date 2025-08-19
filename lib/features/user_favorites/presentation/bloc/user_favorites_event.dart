part of 'user_favorites_bloc.dart';

sealed class UserFavoritesEvent extends Equatable {
  const UserFavoritesEvent();

  @override
  List<Object> get props => <Object>[];
}

final class LoadUserFavoritesEvent extends UserFavoritesEvent {}

final class AddToFavoritesEvent extends UserFavoritesEvent {
  const AddToFavoritesEvent({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object> get props => <Object>[name, id];
}

final class RemovePokemonFromFavoritesEvent extends UserFavoritesEvent {
  const RemovePokemonFromFavoritesEvent(this.names);

  final List<String> names;

  @override
  List<Object> get props => <Object>[names];
}
