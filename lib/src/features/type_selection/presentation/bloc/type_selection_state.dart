part of 'type_selection_bloc.dart';

sealed class TypeSelectionState extends Equatable {
  const TypeSelectionState();

  @override
  List<Object?> get props => <Object?>[];
}

final class TypeSelectionInitial extends TypeSelectionState {}

final class LoadingTypes extends TypeSelectionState {}

final class TypesLoaded extends TypeSelectionState {
  const TypesLoaded(this.types);

  final List<PokemonType> types;

  @override
  List<Object> get props => types.map((PokemonType type) => type.name).toList();
}

class TypeSelectionError extends TypeSelectionState {
  const TypeSelectionError(this.message);

  final String message;

  @override
  List<Object> get props => <Object>[message];
}
