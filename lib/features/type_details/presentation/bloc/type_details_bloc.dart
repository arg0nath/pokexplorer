import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/errors/failures.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';
import 'package:pokexplorer/features/type_details/domain/entities/type_details.dart';
import 'package:pokexplorer/features/type_details/domain/usecases/fetch_type_details.dart';

part 'type_details_bloc.freezed.dart';
part 'type_details_event.dart';
part 'type_details_state.dart';

class TypeDetailsBloc extends Bloc<TypeDetailsEvent, TypeDetailsState> {
  TypeDetailsBloc({required FetchTypeDetails fetchTypeDetails})
      : _fetchTypeDetails = fetchTypeDetails,
        super(_Initial()) {
    on<InitialTypeEvent>((InitialTypeEvent event, Emitter<TypeDetailsState> emit) {
      emit(const TypeDetailsState.initial());
    });

    on<FetchTypeDetailsEvent>((FetchTypeDetailsEvent event, Emitter<TypeDetailsState> emit) async {
      emit(const TypeDetailsState.loading());
      try {
        final Either<Failure, TypeDetails> result = await _fetchTypeDetails(FetchTypeDetailsParams(typeName: event.typeName));
        result.fold((Failure failure) => emit(TypeDetailsState.error(failure.errorMessage)), (TypeDetails typeDetails) {
          _currentTypeDetails = typeDetails;
          emit(TypeDetailsState.loaded(typeDetails));
        });
      } catch (e) {
        emit(TypeDetailsState.error(e.toString()));
      }
    });

    on<SearchPokemonsEvent>((SearchPokemonsEvent event, Emitter<TypeDetailsState> emit) async {
      emit(const TypeDetailsState.searching());
      try {
        if (_currentTypeDetails == null) {
          emit(const TypeDetailsState.error('No type details loaded.'));
          return;
        }
        final String query = event.query.toLowerCase();
        final List<PokemonPreview> results = _currentTypeDetails!.pokemons.where((PokemonPreview p) => p.name.toLowerCase().contains(query)).toList();
        emit(TypeDetailsState.searched(searchResults: results));
      } catch (e) {
        emit(TypeDetailsState.error(e.toString()));
      }
    });

    on<ProceedToPokemonDetailsEvent>((ProceedToPokemonDetailsEvent event, Emitter<TypeDetailsState> emit) {
      emit(TypeDetailsState.readyToProceedToPokemonDetails(ProceedingStatus.proceeding));
      selectedPokemonName = event.pokemonName;
      emit(TypeDetailsState.readyToProceedToPokemonDetails(ProceedingStatus.completed));
    });
  }
  String selectedPokemonName = AppConst.emptyString;
  final FetchTypeDetails _fetchTypeDetails;
  TypeDetails? _currentTypeDetails;
}
