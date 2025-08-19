part of 'type_selection_bloc.dart';

sealed class TypeSelectionEvent extends Equatable {
  const TypeSelectionEvent();

  @override
  List<Object> get props => <Object>[];
}

final class GetTypesEvent extends TypeSelectionEvent {
  const GetTypesEvent();

  @override
  List<Object> get props => <Object>[];
}

final class SelectTypeEvent extends TypeSelectionEvent {
  const SelectTypeEvent({required this.typeName});

  final String typeName;
  @override
  List<Object> get props => <Object>[typeName];
}

final class ProceedToTypeDetails extends TypeSelectionEvent {
  const ProceedToTypeDetails();

  @override
  List<Object> get props => <Object>[];
}
