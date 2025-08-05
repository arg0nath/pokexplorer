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
      await _getUserFavorites().then(
        (Either<Failure, List<PokemonPreview>> result) => result.fold(
          (Failure failure) => emit(UserFavoritesError(failure.message)),
          (List<PokemonPreview> favorites) => emit(UserFavoritesLoaded(favorites)),
        ),
      );
    });
  }

  final GetUserFavorites _getUserFavorites;
  final AddToFavorites _addToFavorites;
  final RemoveFromFavorites _removeFromFavorites;
}
