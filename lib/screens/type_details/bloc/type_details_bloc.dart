import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pokexplorer/screens/favorites/bloc/favorites_bloc.dart';
import 'package:pokexplorer/core/enums/app_enums.dart';
import 'package:pokexplorer/core/variables/app_variables.dart' as app_vars;

import '../../../core/models/app_models.dart' as app_models;
import '../../../core/utilities/app_utils.dart' as app_utils;
import '../../../core/utilities/front_end_utils.dart';
import '../../../core/variables/app_constants.dart' as app_const;

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

      final int fetchLimit = app_const.TYPE_DETAILS_POKEMON_PAGE_SIZE; //10
      final int itemCount = selectedPokemonTypeDetails.pokemon.length;
      final int loopEndIndex = itemCount < fetchLimit ? itemCount : fetchLimit;

      List<app_models.PokemonPreview> userFavorites = List.from(await app_vars.databaseService.getDbPokemonPreviewList());
      favoritePokemonNamesSet = userFavorites.map((e) => e.name).toSet(); // nice method Set is a collection of unique elements
      app_utils.myLog(msg: 'favoritePokemonNamesSet: $favoritePokemonNamesSet');

      for (int i = 0; i < loopEndIndex; i++) {
        selectedTypePokemonPreviewList.add(selectedPokemonTypeDetails.pokemon[i]);
        if (favoritePokemonNamesSet.contains(selectedPokemonTypeDetails.pokemon[i].name)) {
          selectedPokemonTypeDetails.pokemon[i].setIsFavorite(RelationValue.favorite);
        }
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

      emit(TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.loadingMorePokemons, searchedPokemonPreviewList: state.searchedPokemonPreviewList));

      int tmpStartIndex = selectedTypePokemonPreviewList.length; // start where I left

      try {
        for (int i = tmpStartIndex; i < tmpStartIndex + app_const.TYPE_DETAILS_POKEMON_PAGE_SIZE; i++) {
          if (state.typeDetailsStatus != TypeDetailsStatus.loadingMorePokemons) {
            return Future<void>.value();
          }

          if (i < selectedPokemonTypeDetails.pokemon.length) {
            if (!selectedTypePokemonPreviewList.any((pokemonPreview) => pokemonPreview.name == selectedPokemonTypeDetails.pokemon[i].name)) {
              selectedTypePokemonPreviewList.add(selectedPokemonTypeDetails.pokemon[i]);
              if (favoritePokemonNamesSet.contains(selectedPokemonTypeDetails.pokemon[i].name)) {
                selectedPokemonTypeDetails.pokemon[i].setIsFavorite(RelationValue.favorite);
              }
            }
          } else {
            break;
          }
        }

        emit(TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.morePokemonsLoaded, searchedPokemonPreviewList: state.searchedPokemonPreviewList));
      } catch (e) {
        app_utils.myLog(level: app_const.LOG_ERROR, msg: 'loadMore pokemon error: $e');

        emit(TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.morePokemonsLoadedFailed, searchedPokemonPreviewList: state.searchedPokemonPreviewList));
      }
    });

    on<NavigateToDetailsFromTypeDetailsEvent>((NavigateToDetailsFromTypeDetailsEvent event, Emitter<TypeDetailsState> emit) async {
      selectedPokemonPreview = app_models.PokemonPreview.empty();
      selectedPokemonPreview = event.pokemonPreview;
      final bool hasInternet = await InternetConnection().hasInternetAccess;
      if (!hasInternet) {
        emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.notifyingForNoInternetError));
        emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.readyToNotifyForNoInternet));
        return;
      }

      try {
        emit(TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.navigatingToPokemonDetails, searchedPokemonPreviewList: state.searchedPokemonPreviewList));
        selectedPokemon = await frontEndUtils.loadPokemonByName(name: selectedPokemonPreview.name);
        if (selectedPokemonPreview.isFavorite == RelationValue.favorite.value) {
          selectedPokemon.setIsFavorite(RelationValue.favorite);
        }

        emit(TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.readyToNavigateToPokemonDetails, searchedPokemonPreviewList: state.searchedPokemonPreviewList));
      } catch (e) {
        emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.errorNavigateToPokemonDetailsFailed));
      }
    });

    on<UpdateRelationInTypeDetailsEvent>((UpdateRelationInTypeDetailsEvent event, Emitter<TypeDetailsState> emit) async {
      emit(TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.updatingRelationInTypeDetails, searchedPokemonPreviewList: state.searchedPokemonPreviewList));

      final tmpPokemonPreview = event.pokemonPreview;

      //if its not favorite
      if (tmpPokemonPreview.isFavorite == RelationValue.notFavorite.value) {
        tmpPokemonPreview.setIsFavorite(RelationValue.favorite);
        userFavoritesBloc.add(AddPokemonPreviewToFavoritesEvent(pokemonPreview: tmpPokemonPreview));
      }
      // if its favorite
      else {
        tmpPokemonPreview.setIsFavorite(RelationValue.notFavorite);
        userFavoritesBloc.add(RemovePokemonPreviewFromFavoritesEvent(pokemonPreview: tmpPokemonPreview));
      }

      emit(TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.relationInTypeDetailsUpdated, searchedPokemonPreviewList: state.searchedPokemonPreviewList));
    });

    on<ExitTypeDetailsEvent>((ExitTypeDetailsEvent event, Emitter<TypeDetailsState> emit) async {
      emit(TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.exitingTypeDetails, searchedPokemonPreviewList: state.searchedPokemonPreviewList));
      emit(TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.typeDetailsExited, searchedPokemonPreviewList: state.searchedPokemonPreviewList));
    });

    // #region // * Search Events

    on<SearchPokemonEvent>((SearchPokemonEvent event, Emitter<TypeDetailsState> emit) async {
      emit(const TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.searchingPokemon));

      searchedPokemonPreviewList.clear();

      if (event.value.isNotEmpty) {
        final wordToSearch = event.value.trim().toLowerCase();

        try {
          for (final pokemonPreview in allPokemonList) {
            final pokemonNameLower = pokemonPreview.name.toLowerCase();
            if (pokemonNameLower.contains(wordToSearch)) {
              searchedPokemonPreviewList.add(pokemonPreview);
              if (favoritePokemonNamesSet.contains(pokemonNameLower)) {
                pokemonPreview.setIsFavorite(RelationValue.favorite);
              }
            }
          }

          emit(TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.pokemonSearched, searchedPokemonPreviewList: searchedPokemonPreviewList));
        } catch (e) {
          app_utils.myLog(level: app_const.LOG_ERROR, msg: 'Error searching Pokemon: $e');
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

    on<RefreshTypeDetailsEvent>((RefreshTypeDetailsEvent event, Emitter<TypeDetailsState> emit) async {
      emit(TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.refreshingPokemonTypeDetailsRefreshed, searchedPokemonPreviewList: state.searchedPokemonPreviewList));

      List<app_models.PokemonPreview> userFavorites = List.from(await app_vars.databaseService.getDbPokemonPreviewList());
      favoritePokemonNamesSet = {for (var pokemon in userFavorites) pokemon.name};

      if (state.searchedPokemonPreviewList.isEmpty) {
        _updateFavoriteStatus(selectedTypePokemonPreviewList);
        emit(TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.pokemonTypeDetailsRefreshed, searchedPokemonPreviewList: state.searchedPokemonPreviewList));
      } else {
        List<app_models.PokemonPreview> updatedList = List.from(state.searchedPokemonPreviewList);
        _updateFavoriteStatus(updatedList);
        emit(TypeDetailsState(typeDetailsStatus: TypeDetailsStatus.pokemonTypeDetailsRefreshed, searchedPokemonPreviewList: updatedList));
      }
    });

// #endregion
  }

  late final FrontendUtils frontEndUtils;
  TypeDetailsBloc? typeDetailsBloc;
  late final UserFavoritesBloc userFavoritesBloc;
  void setUserFavoritesBloc(UserFavoritesBloc userFavoritesBloc) => this.userFavoritesBloc = userFavoritesBloc;

  String selectedTypeName = app_const.EMPTY_STRING;
  List<app_models.PokemonPreview> selectedTypePokemonPreviewList = [];
  app_models.PokemonPreview selectedPokemonPreview = app_models.PokemonPreview.empty();
  app_models.Pokemon selectedPokemon = app_models.Pokemon.empty();
  app_models.PokemonTypeDetails selectedPokemonTypeDetails = app_models.PokemonTypeDetails.empty();
  List<app_models.PokemonPreview> searchedPokemonPreviewList = <app_models.PokemonPreview>[];
  // late List<app_models.PokemonPreview> favoritePokemons = [];
  List<app_models.PokemonPreview> allPokemonList = [];
  Set<String> favoritePokemonNamesSet = <String>{};

  void initializeTypeDetailsVariables() {
    // favoritePokemons.clear();
    favoritePokemonNamesSet.clear();
    selectedPokemonPreview = app_models.PokemonPreview.empty();
    selectedPokemon = app_models.Pokemon.empty();

    selectedTypeName = app_const.EMPTY_STRING;
    selectedTypePokemonPreviewList.clear();
    selectedPokemonTypeDetails = app_models.PokemonTypeDetails.empty();
    allPokemonList.clear();
  }

  void _updateFavoriteStatus(List<app_models.PokemonPreview> pokemonList) {
    for (var pokemonPreview in pokemonList) {
      pokemonPreview.setIsFavorite(favoritePokemonNamesSet.contains(pokemonPreview.name) ? RelationValue.favorite : RelationValue.notFavorite);
    }
  }
}
