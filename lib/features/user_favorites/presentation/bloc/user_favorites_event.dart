part of 'user_favorites_bloc.dart';

sealed class UserFavoritesEvent extends Equatable {
  const UserFavoritesEvent();

  @override
  List<Object> get props => [];
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
  List<Object> get props => [name, id];
}

final class RemoveFromFavoritesEvent extends UserFavoritesEvent {
  const RemoveFromFavoritesEvent(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}
