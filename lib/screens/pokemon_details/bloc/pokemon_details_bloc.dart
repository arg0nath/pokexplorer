// import 'package:android_path_provider/android_path_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokexplorer/src/utilities/app_utils.dart' as app_utils;
import 'package:pokexplorer/src/variables/app_constants.dart' as app_const;

import '../../../src/models/app_models.dart' as app_models;

import '../../../src/utilities/front_end_utils.dart';

part 'pokemon_details_event.dart';
part 'pokemon_details_state.dart';

class PokemonDetailsBloc extends Bloc<PokemonDetailsEvent, PokemonDetailsState> {
  PokemonDetailsBloc({required this.frontEndUtils}) : super(const PokemonDetailsState(pokemonDetailsStatus: PokemonDetailsStatus.pokemonDetailsNotLoaded)) {
    on<LoadPokemonDetailsEvent>((LoadPokemonDetailsEvent event, Emitter<PokemonDetailsState> emit) async {
      emit(const PokemonDetailsState(pokemonDetailsStatus: PokemonDetailsStatus.loadingPokemonDetails));
      selectedPokemon = app_models.Pokemon.empty();
      try {
        selectedPokemon = event.pokemon;
        pokemonImageList = [selectedPokemon.hqImageUrl, selectedPokemon.lqImageUrl];

        if (selectedPokemon.gifUrl != null) {
          pokemonImageList.add(selectedPokemon.gifUrl!);
        }

        // Emit the success state with the loaded Pokémon details
        emit(const PokemonDetailsState(pokemonDetailsStatus: PokemonDetailsStatus.pokemonDetailsLoaded));
      } catch (e) {
        // Catch any unexpected errors and log them
        app_utils.myLog(app_const.LOG_ERROR, 'Unexpected error loading Pokémon details: $e');
        emit(PokemonDetailsState(
          pokemonDetailsStatus: PokemonDetailsStatus.pokemonDetailsLoadFailed,
          errorMessage: app_const.GENERIC_ERROR_TOAST_MESSAGE,
        ));
      }
    });
  }

  //* BLOC Stuff
  final FrontendUtils frontEndUtils;
  late List<String> pokemonImageList = [];
  late app_models.Pokemon selectedPokemon = app_models.Pokemon.empty();
}
