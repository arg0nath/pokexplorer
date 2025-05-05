import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'type_selection_event.dart';
part 'type_selection_state.dart';

class TypeSelectionBloc extends Bloc<TypeSelectionEvent, TypeSelectionState> {
  TypeSelectionBloc() : super(TypeSelectionInitial()) {
    on<TypeSelectionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
