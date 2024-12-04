// import 'package:android_path_provider/android_path_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pokexplorer/services/db_service.dart';
import 'package:pokexplorer/src/utilities/app_utils.dart' as app_utils;
import 'package:pokexplorer/src/variables/app_constants.dart' as app_const;
import 'package:pokexplorer/src/variables/app_variables.dart' as app_vars;

import '../../../src/models/app_models.dart' as app_models;

import '../../../src/utilities/front_end_utils.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class UserFavoritesBloc extends Bloc<UserFavoritesEvent, UserFavoritesState> {
  UserFavoritesBloc({required this.frontEndUtils}) : super(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.userFavoritesNotLoaded)) {
    on<LoadFavoritesEvent>((LoadFavoritesEvent event, Emitter<UserFavoritesState> emit) async {
      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.loadingUserFavorites));
      initFavoritesVariables();
      userFavorites = List.from(await _databaseService.getDbPokemonPreviewList());
      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.userFavoritesLoaded));
    });

    on<RefreshFavoritesEvent>((RefreshFavoritesEvent event, Emitter<UserFavoritesState> emit) async {
      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.refreshingFavorites));
      initFavoritesVariables();
      userFavorites = List.from(await _databaseService.getDbPokemonPreviewList());

      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.userFavoritesRefreshed));
    });

    on<AddPokemonPreviewToFavoritesEvent>((AddPokemonPreviewToFavoritesEvent event, Emitter<UserFavoritesState> emit) async {
      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.updatingFavorites));

      _databaseService.addFavPokePreviewToDb(imageUrl: event.pokemonPreview.imageUrl, name: event.pokemonPreview.name);
      userFavorites = List.from(await _databaseService.getDbPokemonPreviewList());
      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.favoritesUpdated));
    });

    on<ShowDialogToRemovePokemonPreviewFromFavoritesEvent>((ShowDialogToRemovePokemonPreviewFromFavoritesEvent event, Emitter<UserFavoritesState> emit) async {
      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.showDialogToRemovePokemon));
      selectedPokemonPreviewForDeletion = event.pokemonPreview;
      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.userFavoritesLoaded));
    });

    on<RemovePokemonPreviewFromFavoritesEvent>((RemovePokemonPreviewFromFavoritesEvent event, Emitter<UserFavoritesState> emit) async {
      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.updatingFavorites));

      _databaseService.deleteFavPokePreviewFromDb(name: event.pokemonPreview.name);
      userFavorites = List.from(await _databaseService.getDbPokemonPreviewList());

      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.favoritesUpdated));
    });

    on<DeleteAllFavoritesEvent>((DeleteAllFavoritesEvent event, Emitter<UserFavoritesState> emit) async {
      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.updatingFavorites));

      _databaseService.deleteAllFavPokePreviewFromDb();
      userFavorites = List.from(await _databaseService.getDbPokemonPreviewList());

      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.favoritesUpdated));
    });

    on<NavigateToDetailsFromFavoritesEvent>((NavigateToDetailsFromFavoritesEvent event, Emitter<UserFavoritesState> emit) async {
      selectedPokemonPreview = app_models.PokemonPreview.empty();
      selectedPokemonPreview = event.pokemonPreview;
      final bool hasInternet = await InternetConnection().hasInternetAccess;
      if (!hasInternet) {
        emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.notifyingForNoInternetFavoritesError));
        emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.noInternetFailedFavorites));
        return;
      }

      try {
        emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.navigatingToPokemonDetails));
        selectedPokemon = await frontEndUtils.loadPokemonByName(name: selectedPokemonPreview.name);

        emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.readyToNavigateToPokemonDetails));
      } catch (e) {
        emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.navigateToDetailsFromFavoritesFailed));
      }
      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.userFavoritesLoaded));
    });
  }

  //* BLOC Stuff
  late DatabaseService _databaseService;

  app_models.PokemonPreview selectedPokemonPreview = app_models.PokemonPreview.empty();
  app_models.PokemonPreview selectedPokemonPreviewForDeletion = app_models.PokemonPreview.empty();

  app_models.Pokemon selectedPokemon = app_models.Pokemon.empty();
  List<app_models.PokemonPreview> userFavorites = [];
  final FrontendUtils frontEndUtils;

  void initFavoritesVariables() {
    _databaseService = DatabaseService.instance;
    userFavorites.clear();

    selectedPokemon = app_models.Pokemon.empty();
    selectedPokemonPreview = app_models.PokemonPreview.empty();
    selectedPokemonPreviewForDeletion = app_models.PokemonPreview.empty();
  }
}
