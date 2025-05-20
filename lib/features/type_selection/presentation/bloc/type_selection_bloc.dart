import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pokexplorer/core/error/failures.dart';
import 'package:pokexplorer/core/usecase/no_params.dart';
import 'package:pokexplorer/features/type_selection/domain/entities/pokemon_type.dart';
import 'package:pokexplorer/features/type_selection/domain/usecases/get_local_pokemon_types_usecase.dart';

part 'type_selection_event.dart';
part 'type_selection_state.dart';

class TypeSelectionBloc extends Bloc<TypeSelectionEvent, TypeSelectionState> {
  final GetLocalPokemonTypesUseCase _getPokemonTypesUsecase;
  TypeSelectionBloc({required GetLocalPokemonTypesUseCase getPokemonTypesUsecase})
      : _getPokemonTypesUsecase = getPokemonTypesUsecase,
        super(const TypeSelectionInitial()) {
    on<LoadPokemonTypesEvent>(_loadPokemonTypes);
  }

  void _loadPokemonTypes(
    LoadPokemonTypesEvent event,
    Emitter<TypeSelectionState> emit,
  ) async {
    emit(const LoadingPokemonTypes());
    final Either<Failure, List<PokemonType>> result = await _getPokemonTypesUsecase(params: const NoParams());
    result.fold(
      (Failure failure) => emit(PokemonTypesFailure(message: failure.message)),
      (List<PokemonType> types) => emit(PokemonTypesLoaded(types)),
    );
  }
}
