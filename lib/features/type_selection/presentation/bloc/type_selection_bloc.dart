import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/errors/failures.dart';
import 'package:pokexplorer/features/type_selection/domain/entities/pokemon_type.dart';
import 'package:pokexplorer/features/type_selection/domain/usecases/get_pokemon_types.dart';
import 'package:pokexplorer/features/type_selection/domain/usecases/get_selected_pokemon_type.dart';
import 'package:pokexplorer/features/type_selection/domain/usecases/select_pokemon_types.dart';

part 'type_selection_event.dart';
part 'type_selection_state.dart';

class TypeSelectionBloc extends Bloc<TypeSelectionEvent, TypeSelectionState> {
  TypeSelectionBloc({
    required GetPokemonTypes getPokemonTypes,
    required SelectPokemonType selectPokemonType,
    required GetSelectedPokemonType getSelectedPokemonType,
  })  : _getPokemonTypes = getPokemonTypes,
        _selectPokemonType = selectPokemonType,
        _getSelectedPokemonType = getSelectedPokemonType,
        super(TypeSelectionInitial()) {
    // on<TypeSelectionEvent>((TypeSelectionEvent event, Emitter<TypeSelectionState> emit) {});
    on<GetTypesEvent>(_onGetPokemonTypesHandler);
    on<SelectTypeEvent>(_onSelectTypeHandler);
    on<ProceedToTypeResults>(_onProceedToTypeResultsHandler);
  }

  final GetPokemonTypes _getPokemonTypes;
  final SelectPokemonType _selectPokemonType;
  final GetSelectedPokemonType _getSelectedPokemonType;

  String _selectedTypeName = AppConst.emptyString;
  List<PokemonType> _loadedTypes = <PokemonType>[];

  Future<void> _onGetPokemonTypesHandler(GetTypesEvent event, Emitter<TypeSelectionState> emit) async {
    emit(LoadingTypes());
    final Either<Failure, List<PokemonType>> result = await _getPokemonTypes();

    final Either<Failure, String> tmpResult = await _getSelectedPokemonType();
    tmpResult.fold(
      (Failure failure) => (Failure failure) => emit(TypeSelectionError(failure.errorMessage)),
      (String name) => _selectedTypeName = name,
    );

    result.fold(
      (Failure failure) => emit(TypeSelectionError(failure.errorMessage)),
      (List<PokemonType> types) async {
        _loadedTypes = types;

        emit(TypesLoaded(types, selectedTypeName: _selectedTypeName));
      },
    );
  }

  Future<void> _onSelectTypeHandler(SelectTypeEvent event, Emitter<TypeSelectionState> emit) async {
    String newTypeName = _selectedTypeName == event.typeName ? AppConst.emptyString : event.typeName;

    Either<Failure, void> result = await _selectPokemonType(SelectedPokemonTypeParams(typeName: newTypeName));

    result.fold(
      (Failure failure) => emit(TypeSelectionError(failure.errorMessage)),
      (_) {
        _selectedTypeName = newTypeName;
        emit(TypesLoaded(_loadedTypes, selectedTypeName: _selectedTypeName));
      },
    );
  }

  Future<void> _onProceedToTypeResultsHandler(ProceedToTypeResults event, Emitter<TypeSelectionState> emit) async {
    emit(ProceedingToTypeResults());
    await Future<void>.delayed(5000.ms);
    emit(ReadyToProceedTypeResults());
  }
}
