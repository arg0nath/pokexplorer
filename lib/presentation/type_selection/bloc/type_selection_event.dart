part of 'type_selection_bloc.dart';

abstract class TypeSelectionEvent extends Equatable {
  const TypeSelectionEvent();

  @override
  List<Object> get props => <Object>[];
}

class LoadTypesEvent extends TypeSelectionEvent {
  const LoadTypesEvent();

  @override
  List<Object> get props => <Object>[];
}

class SelectTypeEvent extends TypeSelectionEvent {
  const SelectTypeEvent({required this.type});

  final PokemonType type;
  @override
  List<Object> get props => <Object>[type];
}

class ProceedToTypeDetailsScreenEvent extends TypeSelectionEvent {
  const ProceedToTypeDetailsScreenEvent();

  @override
  List<Object> get props => <Object>[];
}

class ShowInfoDialogEvent extends TypeSelectionEvent {
  const ShowInfoDialogEvent();

  @override
  List<Object> get props => <Object>[];
}
