part of 'type_selection_bloc.dart';

sealed class TypeSelectionState extends Equatable {
  const TypeSelectionState();

  @override
  List<Object> get props => [];
}

final class TypeSelectionInitial extends TypeSelectionState {}

final class LoadingPokemonTypes extends TypeSelectionState {}

final class PokemonTypesLoaded extends TypeSelectionState {}
