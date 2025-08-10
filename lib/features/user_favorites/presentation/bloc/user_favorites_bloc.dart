import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pokexplorer/core/common/errors/failures.dart';
import 'package:pokexplorer/core/common/utils/pokemon/get_poke_image_by_id.dart';
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
        super(LoadingUserFavorites()) {
    on<LoadUserFavoritesEvent>(
      (LoadUserFavoritesEvent event, Emitter<UserFavoritesState> emit) async {
        final Either<Failure, List<PokemonPreview>> result = await _getUserFavorites();

        result.fold((Failure failure) => emit(UserFavoritesError(failure.message)), (List<PokemonPreview> favorites) {
          emit(LoadingUserFavorites());
          emit(UserFavoritesLoaded(favorites));
        });
      },
    );

    on<AddToFavoritesEvent>((AddToFavoritesEvent event, Emitter<UserFavoritesState> emit) async {
      final Either<Failure, void> result = await _addToFavorites(
        AddToFavoritesParams(
          id: event.id,
          name: event.name,
        ),
      );

      await result.fold(
        (Failure failure) async => emit(UserFavoritesError(failure.message)),
        (_) async {
          if (state is UserFavoritesLoaded) {
            final List<PokemonPreview> currentFavorites = List<PokemonPreview>.from(
              (state as UserFavoritesLoaded).favorites,
            );

            // Avoid duplicate entry
            if (!currentFavorites.contains((PokemonPreview fav) => fav.name == event.name)) {
              currentFavorites.add(PokemonPreview(
                id: event.id,
                name: event.name,
                thumbnail: getPokemonBaseImageById(event.id),
              ));
            }
            emit(UpdatingFavoriteStatus(currentFavorites));

            emit(UserFavoritesLoaded(currentFavorites));
          }
        },
      );
    });

    on<RemoveFromFavoritesEvent>((RemoveFromFavoritesEvent event, Emitter<UserFavoritesState> emit) async {
      final Either<Failure, void> result = await _removeFromFavorites(
        RemoveFromFavoritesParams(name: event.name),
      );

      await result.fold(
        (Failure failure) async => emit(UserFavoritesError(failure.message)),
        (_) async {
          if (state is UserFavoritesLoaded) {
            final List<PokemonPreview> currentFavorites = List<PokemonPreview>.from(
              (state as UserFavoritesLoaded).favorites,
            )..removeWhere((PokemonPreview fav) => fav.name == event.name);
            emit(UpdatingFavoriteStatus(currentFavorites));

            emit(UserFavoritesLoaded(currentFavorites));
          }
        },
      );
    });
  }

  final GetUserFavorites _getUserFavorites;
  final AddToFavorites _addToFavorites;
  final RemoveFromFavorites _removeFromFavorites;
}
