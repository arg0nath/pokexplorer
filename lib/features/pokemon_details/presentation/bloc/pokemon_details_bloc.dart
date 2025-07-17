import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokexplorer/core/common/errors/failures.dart';
import 'package:pokexplorer/features/pokemon_details/domain/entities/pokemon_details.dart';
import 'package:pokexplorer/features/pokemon_details/domain/usecases/fetch_pokemon_details.dart';

part 'pokemon_details_bloc.freezed.dart';
part 'pokemon_details_event.dart';
part 'pokemon_details_state.dart';

// TODO(future plans): experiment with freezed union types for better state management. If i dont like it,
// TODO(future plans): revert to the previous implementation (sweet equateble)
// TODO(future plans): message for future me: yes change it...

class PokemonDetailsBloc extends Bloc<PokemonDetailsEvent, PokemonDetailsState> {
  PokemonDetailsBloc({required FetchPokemonDetails fetchPokemonDetails})
      : _fetchPokemonDetails = fetchPokemonDetails,
        super(_Initial()) {
    on<InitialPokeDetailsEvent>((InitialPokeDetailsEvent event, Emitter<PokemonDetailsState> emit) {
      emit(const PokemonDetailsState.initial());
    });

    on<FetchPokemonDetailsEvent>((FetchPokemonDetailsEvent event, Emitter<PokemonDetailsState> emit) async {
      emit(const PokemonDetailsState.loading());
      try {
        final Either<Failure, PokemonDetails> result = await _fetchPokemonDetails(FetchPokemonDetailsParams(name: event.name));
        result.fold(
          (Failure failure) => emit(PokemonDetailsState.error(failure.errorMessage)),
          (PokemonDetails pokemonDetails) => emit(PokemonDetailsState.loaded(pokemonDetails)),
        );
      } catch (e) {
        emit(PokemonDetailsState.error(e.toString()));
      }
    });
  }
  final FetchPokemonDetails _fetchPokemonDetails;
}
