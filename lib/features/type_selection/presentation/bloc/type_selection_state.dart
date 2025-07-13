part of 'type_selection_bloc.dart';

sealed class TypeSelectionState extends Equatable {
  const TypeSelectionState();

  @override
  List<Object?> get props => <Object?>[];
}

final class TypeSelectionInitial extends TypeSelectionState {}

final class LoadingTypes extends TypeSelectionState {}

final class TypesLoaded extends TypeSelectionState {
  const TypesLoaded(this.types, {required this.selectedTypeName});

  final List<PokemonType> types;
  final String selectedTypeName;

  @override
  List<Object> get props => [...types.map((PokemonType type) => type.name), selectedTypeName];
}

final class TypeSelectionError extends TypeSelectionState {
  const TypeSelectionError(this.message);

  final String message;

  @override
  List<Object> get props => <Object>[message];
}

final class SelectingType extends TypeSelectionState {}

class TypeSelected extends TypeSelectionState {
  const TypeSelected(this.selectedTypeName);
  final String selectedTypeName;

  @override
  List<Object> get props => <Object>[selectedTypeName];
}

class ReadyToProceedTypeResults extends TypeSelectionState {
  const ReadyToProceedTypeResults();
  @override
  List<Object> get props => <Object>[];
}
