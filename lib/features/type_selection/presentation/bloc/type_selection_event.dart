part of 'type_selection_bloc.dart';

sealed class TypeSelectionEvent extends Equatable {
  const TypeSelectionEvent();

  @override
  List<Object> get props => [];
}

final class LoadPokemonTypesEvent extends TypeSelectionEvent {
  const LoadPokemonTypesEvent();

  @override
  List<Object> get props => [];
}

final class ToggleTypeSelection extends TypeSelectionEvent {
  const ToggleTypeSelection({required this.typeName});

  final String typeName;

  @override
  List<Object> get props => [typeName];
}
