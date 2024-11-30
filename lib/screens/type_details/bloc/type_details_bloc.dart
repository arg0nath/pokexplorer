import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

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

      initializeTypeDetailsVariables();
      selectedTypeName = event.typeDetails.name;

      selectedPokemonTypeDetails = event.typeDetails;
      allPokemonList = List.from(selectedPokemonTypeDetails.pokemon);

      final int fetchLimit = app_const.TYPE_DETAILS_POKEMON_PAGE_SIZE;
      final int itemCount = selectedPokemonTypeDetails.pokemon.length;
      final int loopEndIndex = itemCount < fetchLimit ? itemCount : fetchLimit;

      for (int i = 0; i < loopEndIndex; i++) {
        selectedTypePokemonPreviewList.add(selectedPokemonTypeDetails.pokemon[i]);
      }

      emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.pokemonsLoaded));
    });

    on<LoadMoreTypeDetailsPokemonsEvent>((LoadMoreTypeDetailsPokemonsEvent event, Emitter<TypeDetailsState> emit) async {
      if (state.typeDetailsStatus == TypeDetailsStatus.loadingMorePokemons) {
        return; // rrevent re-emitting
      }

      bool hasInternetAccess = await InternetConnection().hasInternetAccess;
      if (!hasInternetAccess) {
        emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.readyToNotifyForNoInternet));
        return;
      }

      emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.loadingMorePokemons));

      int tmpStartIndex = selectedTypePokemonPreviewList.length; // start where I left

      try {
        for (int i = tmpStartIndex; i < tmpStartIndex + app_const.TYPE_DETAILS_POKEMON_PAGE_SIZE; i++) {
          if (state.typeDetailsStatus != TypeDetailsStatus.loadingMorePokemons) {
            return Future<void>.value();
          }

          if (i < selectedPokemonTypeDetails.pokemon.length) {
            if (!selectedTypePokemonPreviewList.any((pokemonPreview) {
              return pokemonPreview.name == selectedPokemonTypeDetails.pokemon[i].name;
            })) {
              await Future.delayed(Duration(milliseconds: 20)).then((value) {
                selectedTypePokemonPreviewList.add(selectedPokemonTypeDetails.pokemon[i]);
              });
            }
          } else {
            break;
          }
        }

        emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.morePokemonsLoaded));
      } catch (e) {
        app_utils.myLog(app_const.LOG_ERROR, 'loadMore pokemon error: $e');

        emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.morePokemonsLoadedFailed));
      }
    });

    on<NavigateToPokemonDetailsEvent>((NavigateToPokemonDetailsEvent event, Emitter<TypeDetailsState> emit) async {
      selectedPokemonPreview = app_models.PokemonPreview.empty();
      selectedPokemonPreview = event.pokemonPreview;
      final bool hasInternetawait = await InternetConnection().hasInternetAccess;
      if (!hasInternetawait) {
        emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.notifyingForNoInternetError));
        emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.readyToNotifyForNoInternet));
        return;
      }

      try {
        emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.navigatingToPokemonDetails));
        selectedPokemon = await frontEndUtils.loadPokemonByName(name: selectedPokemonPreview.name);

        emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.readyToNavigateToPokemonDetails));
      } catch (e) {
        emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.errorNavigateToPokemonDetailsFailed));
      }
    });

    on<ExitTypeDetailsEvent>((ExitTypeDetailsEvent event, Emitter<TypeDetailsState> emit) async {
      emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.exitingTypeDetails));
      emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.typeDetailsExited));
    });

    on<SearchPokemonEvent>((SearchPokemonEvent event, Emitter<TypeDetailsState> emit) async {
      emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.searchingPokemon));

      searchedPokemonPreviewList.clear();

      if (event.value.isNotEmpty) {
        final wordToSearch = event.value.trim().toLowerCase();

        try {
          for (final pokemonPreview in allPokemonList) {
            if (pokemonPreview.name.toLowerCase().contains(wordToSearch)) {
              searchedPokemonPreviewList.add(pokemonPreview);
            }
          }

          emit(TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.pokemonSearched, searchedPokemonPreviewList: searchedPokemonPreviewList));
        } catch (e) {
          app_utils.myLog(app_const.LOG_ERROR, 'Error searching Pokemon: $e');
          emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.pokemonSearched, searchedPokemonPreviewList: []));
        }
      } else {
        // if search word is empt emit no results
        emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.pokemonSearched, searchedPokemonPreviewList: []));
      }
    });

    on<ReturnFromSearchEvent>((ReturnFromSearchEvent event, Emitter<TypeDetailsState> emit) async {
      emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.cancelingSearch));
      searchedPokemonPreviewList.clear();
      emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.searchCancelled));
    });
  }

  late final FrontendUtils frontEndUtils;
  TypeDetailsBloc? typeDetailsBloc;
  void setTypeDetailsBloc(TypeDetailsBloc typeDetailsBloc) => typeDetailsBloc;

  String selectedTypeName = app_const.EMPTY_STRING;
  List<app_models.PokemonPreview> selectedTypePokemonPreviewList = [];
  app_models.PokemonPreview selectedPokemonPreview = app_models.PokemonPreview.empty();
  app_models.Pokemon selectedPokemon = app_models.Pokemon.empty();

  app_models.PokemonTypeDetails selectedPokemonTypeDetails = app_models.PokemonTypeDetails.empty();

  List<app_models.PokemonPreview> searchedPokemonPreviewList = <app_models.PokemonPreview>[];

  List<app_models.PokemonPreview> allPokemonList = [];

  void initializeTypeDetailsVariables() {
    selectedPokemonPreview = app_models.PokemonPreview.empty();
    selectedPokemon = app_models.Pokemon.empty();

    selectedTypeName = app_const.EMPTY_STRING;
    selectedTypePokemonPreviewList.clear();
    selectedPokemonTypeDetails = app_models.PokemonTypeDetails.empty();
    allPokemonList.clear();
  }
}
