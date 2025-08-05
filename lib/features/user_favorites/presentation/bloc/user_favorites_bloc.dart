import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';
import 'package:pokexplorer/features/user_favorites/domain/usecases/get_user_favorites.dart';

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
    on<UserFavoritesEvent>((event, emit) {});
  }

  final GetUserFavorites _getUserFavorites;
  final AddToFavorites _addToFavorites;
  final RemoveFromFavorites _removeFromFavorites;
}
