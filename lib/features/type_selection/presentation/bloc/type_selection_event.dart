part of 'type_selection_bloc.dart';

sealed class TypeSelectionEvent extends Equatable {
  const TypeSelectionEvent();

  @override
  List<Object> get props => [];
}

final class GetTypesEvent extends TypeSelectionEvent {
  const GetTypesEvent();

  @override
  List<Object> get props => [];
}

final class SelectTypeEvent extends TypeSelectionEvent {
  const SelectTypeEvent({required this.typeName});

  final String typeName;
  @override
  List<Object> get props => [typeName];
}

final class ProceedToTypeDetails extends TypeSelectionEvent {
  const ProceedToTypeDetails();

  @override
  List<Object> get props => [];
}
