// import 'package:android_path_provider/android_path_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pokexplorer/core/common/enums/app_enums.dart';
import 'package:pokexplorer/core/common/variables/app_variables.dart' as app_vars;

import '../../../core/common/models/app_models.dart' as app_models;
import '../../../domain/front_end_utils.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class UserFavoritesBloc extends Bloc<UserFavoritesEvent, UserFavoritesState> {
  UserFavoritesBloc({required this.frontEndUtils}) : super(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.loadingUserFavorites)) {
    on<LoadFavoritesEvent>((LoadFavoritesEvent event, Emitter<UserFavoritesState> emit) async {
      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.loadingUserFavorites));
      initFavoritesVariables();
      userFavorites = List.from(await app_vars.databaseService.getDbPokemonPreviewList());
      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.userFavoritesLoaded));
    });

    on<RefreshFavoritesEvent>((RefreshFavoritesEvent event, Emitter<UserFavoritesState> emit) async {
      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.refreshingFavorites));

      userFavorites = List.from(await app_vars.databaseService.getDbPokemonPreviewList());

      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.userFavoritesRefreshed));
    });

    on<AddPokemonPreviewToFavoritesEvent>((AddPokemonPreviewToFavoritesEvent event, Emitter<UserFavoritesState> emit) async {
      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.updatingFavorites));

      await app_vars.databaseService.addFavPokePreviewToDb(imageUrl: event.pokemonPreview.imageUrl, name: event.pokemonPreview.name);
      userFavorites = List.from(await app_vars.databaseService.getDbPokemonPreviewList());
      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.favoritesUpdated));
    });

    on<ShowDialogToRemoveFavoriteEvent>((ShowDialogToRemoveFavoriteEvent event, Emitter<UserFavoritesState> emit) async {
      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.showingDialogToRemovePokemon));
      selectedPokemonPreviewForDeletion = event.pokemonPreview;
      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.showDialogToRemovePokemon));
    });

    on<RemovePokemonPreviewFromFavoritesEvent>((RemovePokemonPreviewFromFavoritesEvent event, Emitter<UserFavoritesState> emit) async {
      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.removingPokemon));

      await app_vars.databaseService.deleteFavPokePreviewFromDb(name: event.pokemonPreview.name);
      userFavorites = List.from(await app_vars.databaseService.getDbPokemonPreviewList());

      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.pokemonRemoved));
    });

    on<ShowDialogToDeleteAllEvent>((ShowDialogToDeleteAllEvent event, Emitter<UserFavoritesState> emit) async {
      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.showingDialogToDeleteAll));

      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.showDialogToDeleteAll));
    });

    on<DeleteAllFavoritesEvent>((DeleteAllFavoritesEvent event, Emitter<UserFavoritesState> emit) async {
      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.deletingAllPokemon));

      await app_vars.databaseService.deleteAllFavPokePreviewFromDb();
      userFavorites = List.from(await app_vars.databaseService.getDbPokemonPreviewList());

      emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.allPokemonDeleted));
    });

    on<NavigateToDetailsFromFavoritesEvent>((NavigateToDetailsFromFavoritesEvent event, Emitter<UserFavoritesState> emit) async {
      final bool hasInternet = await InternetConnection().hasInternetAccess;
      if (!hasInternet) {
        emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.notifyingForNoInternetFavoritesError));
        emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.noInternetFailedFavorites));
        return;
      }

      try {
        emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.navigatingToPokemonDetails));
        selectedPokemonPreview = app_models.PokemonPreview.empty();
        selectedPokemonPreview = event.pokemonPreview;
        selectedPokemon = await frontEndUtils.loadPokemonByName(name: selectedPokemonPreview.name);
        selectedPokemon.setIsFavorite(RelationValue.favorite);

        emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.readyToNavigateToPokemonDetails));
      } catch (e) {
        emit(const UserFavoritesState(userFavoritesStatus: UserFavoritesStatus.navigateToDetailsFromFavoritesFailed));
      }
    });
  }

  //* BLOC Stuff

  app_models.PokemonPreview selectedPokemonPreview = app_models.PokemonPreview.empty();
  app_models.PokemonPreview selectedPokemonPreviewForDeletion = app_models.PokemonPreview.empty();

  app_models.Pokemon selectedPokemon = app_models.Pokemon.empty();
  List<app_models.PokemonPreview> userFavorites = [];
  final FrontendUtils frontEndUtils;

  void initFavoritesVariables() {
    // userFavorites.clear();

    selectedPokemon = app_models.Pokemon.empty();
    selectedPokemonPreview = app_models.PokemonPreview.empty();
    selectedPokemonPreviewForDeletion = app_models.PokemonPreview.empty();
  }
}
