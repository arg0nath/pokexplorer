// import 'package:android_path_provider/android_path_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokexplorer/screens/type_details/bloc/type_details_bloc.dart';
import 'package:pokexplorer/core/enums/app_enums.dart';
import 'package:pokexplorer/core/utilities/app_utils.dart' as app_utils;

import '../../../core/models/app_models.dart' as app_models;

import '../../../core/utilities/front_end_utils.dart';

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

      app_utils.myLog(msg: 'SeletectedPreview:$selectedPokemonPreview');

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

    on<UpdatePokemonRelationEvent>((UpdatePokemonRelationEvent event, Emitter<PokemonDetailsState> emit) async {
      emit(const PokemonDetailsState(pokemonDetailsStatus: PokemonDetailsStatus.updatingPokemoPreviewRelation));
      //if its not favorite, add it to favorites
      if (selectedPokemonPreview.isFavorite == RelationValue.notFavorite.value) {
        selectedPokemon.setIsFavorite(RelationValue.favorite);
      }
      // if its favorite, unfavore it
      else {
        selectedPokemon.setIsFavorite(RelationValue.notFavorite);
      }
      typeDetailsBloc.add(UpdateRelationInTypeDetailsEvent(pokemonPreview: selectedPokemonPreview));
      emit(const PokemonDetailsState(pokemonDetailsStatus: PokemonDetailsStatus.pokemoPreviewRelationUpdated));
    });

    on<ExitPokemonDetailsEvent>((ExitPokemonDetailsEvent event, Emitter<PokemonDetailsState> emit) async {
      emit(const PokemonDetailsState(pokemonDetailsStatus: PokemonDetailsStatus.exitingPokemonDetails));

      typeDetailsBloc.add(const RefreshTypeDetailsEvent()); //refresh list
      emit(const PokemonDetailsState(pokemonDetailsStatus: PokemonDetailsStatus.readyToExitPokemonDetails));
    });
  }

  //* BLOC Stuff

  late final TypeDetailsBloc typeDetailsBloc;
  void setTypeDetailsBloc(TypeDetailsBloc typeDetailsBloc) => this.typeDetailsBloc = typeDetailsBloc;

  final FrontendUtils frontEndUtils;
  late List<String> pokemonImageList = [];

  late app_models.Pokemon selectedPokemon = app_models.Pokemon.empty();
  late app_models.PokemonPreview selectedPokemonPreview = app_models.PokemonPreview.empty();

  void initPokeDetailsVariables() {
    pokemonImageList.clear();
    selectedPokemonPreview = app_models.PokemonPreview.empty();

    selectedPokemon = app_models.Pokemon.empty();
  }
}