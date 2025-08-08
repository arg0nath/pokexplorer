import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pokexplorer/core/common/errors/failures.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';
import 'package:pokexplorer/features/user_favorites/domain/usecases/add_to_favorites.dart';
import 'package:pokexplorer/features/user_favorites/domain/usecases/get_user_favorites.dart';
import 'package:pokexplorer/features/user_favorites/domain/usecases/remove_from_favorites.dart';

part 'user_favorites_event.dart';
part 'user_favorites_state.dart';

class UserFavoritesBloc extends Bloc<UserFavoritesEvent, UserFavoritesState> {
  UserFavoritesBloc({
    required GetUserFavorites getUserFavorites,
    required AddToFavorites addToFavorites,
    required RemoveFromFavorites removeFromFavorites,
  })  : _getUserFavorites = getUserFavorites,
        _addToFavorites = addToFavorites,
        _removeFromFavorites = removeFromFavorites,
        super(UserFavoritesInitial()) {
    on<LoadUserFavoritesEvent>((LoadUserFavoritesEvent event, Emitter<UserFavoritesState> emit) async {
      emit(LoadingUserFavorites());
      final Either<Failure, List<PokemonPreview>> result = await _getUserFavorites();

      result.fold(
        (Failure failure) => emit(UserFavoritesError(failure.message)),
        (List<PokemonPreview> favorites) => emit(UserFavoritesLoaded(favorites)),
      );
    });

    on<AddToFavoritesEvent>((AddToFavoritesEvent event, Emitter<UserFavoritesState> emit) async {
      emit(UpdatingFavoriteStatus());

      final Either<Failure, void> result = await _addToFavorites(AddToFavoritesParams(pokePreview: event.preview));

      await result.fold(
        (Failure failure) async {
          emit(UserFavoritesError(failure.message));
        },
        (_) async {
          final Either<Failure, List<PokemonPreview>> favs = await _getUserFavorites();
          favs.fold(
            (Failure failure) => emit(UserFavoritesError(failure.message)),
            (List<PokemonPreview> favorites) => emit(FavoriteStatusUpdated(favorites)),
          );
        },
      );
    });

    on<RemoveFromFavoritesEvent>((RemoveFromFavoritesEvent event, Emitter<UserFavoritesState> emit) async {
      emit(UpdatingFavoriteStatus());

      final Either<Failure, void> result = await _removeFromFavorites(RemoveFromFavoritesParams(id: event.pokemonId));

      await result.fold(
        (Failure failure) async {
          emit(UserFavoritesError(failure.message));
        },
        (_) async {
          final Either<Failure, List<PokemonPreview>> favs = await _getUserFavorites();
          favs.fold(
            (Failure failure) => emit(UserFavoritesError(failure.message)),
            (List<PokemonPreview> favorites) => emit(FavoriteStatusUpdated(favorites)),
          );
        },
      );
    });
  }

  final GetUserFavorites _getUserFavorites;
  final AddToFavorites _addToFavorites;
  final RemoveFromFavorites _removeFromFavorites;
}
