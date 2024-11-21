import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../src/models/app_models.dart' as app_models;
import '../../../src/utilities/app_utils.dart' as app_utils;
import '../../../src/utilities/front_end_utils.dart';
import '../../../src/variables/app_constants.dart' as app_const;

part 'type_details_event.dart';
part 'type_details_state.dart';

class TypeDetailsBloc extends Bloc<TypeDetailsEvent, TypeDetailsState> {
  TypeDetailsBloc({required this.frontEndUtils}) : super(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.typeDetailsNotLoaded)) {
    typeDetailsBloc = this;

    on<LoadTypeDetailsPokemonsEvent>((LoadTypeDetailsPokemonsEvent event, Emitter<TypeDetailsState> emit) async {
      emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.loadingPokemons));
      await app_utils.loadPrefs(frontEndUtils);
      //init vars
      initializeVariables();

      selectedTypeName = event.typeName.toLowerCase();

      final selectedPokemonTypeDetails = await frontEndUtils.loadTypeDetails(type: selectedTypeName);

      // for for debug test only // ? for (var i = 0; i < 24; i++) {selectedTypePokemonPreviewList.add(selectedPokemonTypeDetails.pokemon[i]);}

      selectedTypePokemonPreviewList = List.from(selectedPokemonTypeDetails.pokemon);

      final int fetchLimit = app_const.TYPE_DETAILS_POKEMON_PAGE_SIZE;
      final int itemCount = selectedTypePokemonPreviewList.length;
      final int loopEndIndex = itemCount < fetchLimit ? itemCount : fetchLimit;
      totalIndexForDialog = loopEndIndex;
      try {
        for (int i = 0; i < (loopEndIndex); i++) {
          emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.loadingOnePokemon)); //only for dialog refrsh purpuse

          final tmpPokemon = await frontEndUtils.loadPokemonByName(name: selectedTypePokemonPreviewList[i].name.toLowerCase());
          finalPokemonList.add(tmpPokemon);
          currentIndexForDialog = i + 1;
          emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.onePokemonLoaded));
        }
        emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.pokemonsLoaded));
      } catch (e) {
        emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.pokemonsLoadedFailed));
      }
    });

    on<LoadMoreTypeDetailsPokemonsEvent>((LoadMoreTypeDetailsPokemonsEvent event, Emitter<TypeDetailsState> emit) async {
      if (state.typeDetailsStatus == TypeDetailsStatus.loadingMorePokemons) {
        return; //prevent re\emitting
      }
      emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.loadingMorePokemons));

      if (state.typeDetailsStatus != TypeDetailsStatus.loadingMorePokemons) {
        return Future<void>.value();
      }

      int tmpStartIndex = finalPokemonList.length; // start where i stop in the previous event emiission

      for (int i = tmpStartIndex; i < tmpStartIndex + app_const.TYPE_DETAILS_POKEMON_PAGE_SIZE; i++) {
        if (i < selectedTypePokemonPreviewList.length) {
          final tmpPokemon = await frontEndUtils.loadPokemonByName(name: selectedTypePokemonPreviewList[i].name.toLowerCase());

          if (!finalPokemonList.any((element) => element.id == tmpPokemon.id)) {
            finalPokemonList.add(tmpPokemon);
          }
        } else {
          break; // eo list
        }
      }

      emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.morePokemonsLoaded));
    });

    on<NavigateToPokemonDetailsEvent>((NavigateToPokemonDetailsEvent event, Emitter<TypeDetailsState> emit) async {
      selectedPokemon = app_models.Pokemon.empty();
      selectedPokemon = event.pokemon;
      emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.navigatingToPokemonDetails));

      emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.readyToNavigateToPokemonDetails));
    });

    on<ExitTypeDetailsEvent>((ExitTypeDetailsEvent event, Emitter<TypeDetailsState> emit) async {
      emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.exitingTypeDetails));

      emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.typeDetailsExited));
    });

    on<SearchPokemonEvent>((SearchPokemonEvent event, Emitter<TypeDetailsState> emit) async {
      emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.searchingPokemon));
      searchedPokemonList.clear();
      if (event.value.isNotEmpty) {
        final wordToSearch = event.value.trim();
        try {
          final searchedPokemon = await frontEndUtils.loadPokemonByName(name: wordToSearch);
          if (searchedPokemon.types.any((element) => selectedTypeName == element.name)) {
            //search in specific category
            searchedPokemonList.add(searchedPokemon);
          }
        } catch (e) {
          searchedPokemonList.clear();
        }
      }
      emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.pokemonSearched));
    });

    on<ReturnFromSearchEvent>((ReturnFromSearchEvent event, Emitter<TypeDetailsState> emit) async {
      emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.cancelingSearch));
      searchedPokemonList.clear();
      emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.searchCancelled));
    });
  }

  late final FrontendUtils frontEndUtils;
  TypeDetailsBloc? typeDetailsBloc;
  void setTypeDetailsBloc(TypeDetailsBloc typeDetailsBloc) => typeDetailsBloc;

  String selectedTypeName = app_const.EMPTY_STRING;
  List<app_models.PokemonPreview> selectedTypePokemonPreviewList = [];
  app_models.Pokemon selectedPokemon = app_models.Pokemon.empty();
  List<app_models.Pokemon> finalPokemonList = <app_models.Pokemon>[];
  int currentIndexForDialog = 1;
  int totalIndexForDialog = 0;

  List<app_models.Pokemon> searchedPokemonList = <app_models.Pokemon>[];

  void initializeVariables() {
    selectedPokemon = app_models.Pokemon.empty();
    selectedTypeName = app_const.EMPTY_STRING;
    selectedTypePokemonPreviewList.clear();
    finalPokemonList.clear();
    searchedPokemonList.clear();
    currentIndexForDialog = 1;
    totalIndexForDialog = 0;
  }
}
