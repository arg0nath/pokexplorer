import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'type_results_event.dart';
part 'type_results_state.dart';

class TypeResultsBloc extends Bloc<TypeResultsEvent, TypeResultsState> {
  TypeResultsBloc() : super(TypeResultsInitial()) {
    on<TypeResultsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
