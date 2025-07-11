import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pokexplorer/core/common/errors/failures.dart';
import 'package:pokexplorer/src/features/type_selection/domain/entities/pokemon_type.dart';
import 'package:pokexplorer/src/features/type_selection/domain/usecases/get_pokemon_types.dart';

part 'type_selection_event.dart';
part 'type_selection_state.dart';

class TypeSelectionBloc extends Bloc<TypeSelectionEvent, TypeSelectionState> {
  TypeSelectionBloc({
    required GetPokemonTypes getPokemonTypes,
  })  : _getPokemonTypes = getPokemonTypes,
        super(TypeSelectionInitial()) {
    // on<TypeSelectionEvent>((TypeSelectionEvent event, Emitter<TypeSelectionState> emit) {});
    on<GetTypesEvent>(_onGetPokemonTypesHandler);
  }

  final GetPokemonTypes _getPokemonTypes;

  _onGetPokemonTypesHandler(GetTypesEvent event, Emitter<TypeSelectionState> emit) async {
    emit(LoadingTypes());
    final Either<Failure, List<PokemonType>> result = await _getPokemonTypes();

    result.fold(
      (Failure failure) => emit(TypeSelectionError(failure.errorMessage)),
      (List<PokemonType> users) => emit(TypesLoaded(users)),
    );
  }
}
