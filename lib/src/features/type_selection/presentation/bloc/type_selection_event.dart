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
