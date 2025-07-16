import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/errors/failures.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';
import 'package:pokexplorer/features/type_details/domain/entities/type_details.dart';
import 'package:pokexplorer/features/type_details/domain/usecases/fetch_type_details.dart';

part 'type_details_bloc.freezed.dart';
part 'type_details_event.dart';
part 'type_details_state.dart';

// TODO(future plans): experiment with freezed union types for better state management. If i dont like it,
// TODO(future plans): revert to the previous implementation (sweet equateble)
// TODO(future plans): message for future me: yes change it...

class TypeDetailsBloc extends Bloc<TypeDetailsEvent, TypeDetailsState> {
  TypeDetailsBloc({required FetchTypeDetails fetchTypeDetails})
      : _fetchTypeDetails = fetchTypeDetails,
        super(_Initial()) {
    /* 
    on<TypeDetailsEvent>((TypeDetailsEvent event, Emitter<TypeDetailsState> emit) async {
      await event.when(
        started: () async {
          emit(const TypeDetailsState.initial());
        },
        fetchTypeDetails: (String typeName) async {
          emit(const TypeDetailsState.loading());
          try {
            // Assuming fetchTypeDetails is a method that fetches type details
            final Either<Failure, TypeDetails> result = await _fetchTypeDetails(FetchTypeDetailsParams(typeName: typeName));
            result.fold(
              (Failure failure) => emit(TypeDetailsState.error(failure.errorMessage)),
              (TypeDetails typeDetails) => emit(TypeDetailsState.loaded(typeDetails)),
            );
          } catch (e) {
            emit(TypeDetailsState.error(e.toString()));
          }
        },
      );
    }); */

    on<_Started>((_Started event, Emitter<TypeDetailsState> emit) {
      emit(const TypeDetailsState.initial());
    });

    on<_FetchTypeDetails>((_FetchTypeDetails event, Emitter<TypeDetailsState> emit) async {
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

    on<_SearchPokemons>((_SearchPokemons event, Emitter<TypeDetailsState> emit) async {
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

    on<_ProceedToPokemonDetails>((_ProceedToPokemonDetails event, Emitter<TypeDetailsState> emit) {
      emit(TypeDetailsState.readyToProceedToPokemonDetails(ProceedingStatus.proceeding));
      selectedPokemonName = event.pokemonName;
      emit(TypeDetailsState.readyToProceedToPokemonDetails(ProceedingStatus.completed));
    });
  }
  String selectedPokemonName = AppConst.emptyString;
  final FetchTypeDetails _fetchTypeDetails;
  TypeDetails? _currentTypeDetails;
}
