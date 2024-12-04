// import 'package:android_path_provider/android_path_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pokexplorer/screens/favorites/bloc/favorites_bloc.dart';
import 'package:pokexplorer/screens/type_details/bloc/type_details_bloc.dart';
import 'package:pokexplorer/screens/type_selection/bloc/type_selection_bloc.dart';
import 'package:pokexplorer/services/db_service.dart';
import 'package:pokexplorer/src/utilities/app_utils.dart' as app_utils;
import 'package:pokexplorer/src/variables/app_constants.dart' as app_const;

import '../../../src/models/app_models.dart' as app_models;

import '../../../src/utilities/front_end_utils.dart';

part 'pokemon_details_event.dart';
part 'pokemon_details_state.dart';

class PokemonDetailsBloc extends Bloc<PokemonDetailsEvent, PokemonDetailsState> {
  PokemonDetailsBloc({required this.frontEndUtils}) : super(const PokemonDetailsState(pokemonDetailsStatus: PokemonDetailsStatus.loadingPokemonDetails)) {
    on<LoadPokemonDetailsEvent>((LoadPokemonDetailsEvent event, Emitter<PokemonDetailsState> emit) async {
      emit(const PokemonDetailsState(pokemonDetailsStatus: PokemonDetailsStatus.loadingPokemonDetails));
      initPokeDetailsVariables();

      selectedPokemon = event.pokemon;
      selectedPokemonPreview = app_models.PokemonPreview(
        id: selectedPokemon.id,
        name: selectedPokemon.name,
        imageUrl: selectedPokemon.baseImageUrl,
        isFavorite: selectedPokemon.isFavorite,
      );

      if (selectedPokemon.baseImageUrl.isNotEmpty) {
        pokemonImageList.add(selectedPokemon.baseImageUrl);
      }
      if (selectedPokemon.gifUrl != null) {
        pokemonImageList.add(selectedPokemon.gifUrl!);
      }

      if (selectedPokemon.hdImageUrl.isNotEmpty) {
        pokemonImageList.add(selectedPokemon.hdImageUrl);
      }

      emit(const PokemonDetailsState(pokemonDetailsStatus: PokemonDetailsStatus.pokemonDetailsLoaded));
    });
  }

  //* BLOC Stuff
  final FrontendUtils frontEndUtils;
  late List<String> pokemonImageList = [];
  // late DatabaseService _databaseService;
  late app_models.Pokemon selectedPokemon = app_models.Pokemon.empty();
  late app_models.PokemonPreview selectedPokemonPreview = app_models.PokemonPreview.empty();

  void initPokeDetailsVariables() {
    // _databaseService = DatabaseService.instance;
    pokemonImageList.clear();
    selectedPokemonPreview = app_models.PokemonPreview.empty();

    selectedPokemon = app_models.Pokemon.empty();
  }
}
