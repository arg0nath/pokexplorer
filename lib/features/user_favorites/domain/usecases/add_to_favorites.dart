import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/config/usecase/usecase.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';
import 'package:pokexplorer/features/user_favorites/domain/repo/user_favorites_repo.dart';

class AddToFavorites extends UseCaseWithParams<void, AddToFavoritesParams> {
  const AddToFavorites(this._userFavoritesRepo);

  final UserFavoritesRepo _userFavoritesRepo;

  @override
  ResultFutureVoid call(AddToFavoritesParams params) async => _userFavoritesRepo.addToFavorites(pokePreview: params.pokePreview);
}

class AddToFavoritesParams {
  const AddToFavoritesParams({
    required this.pokePreview,
  });

  final PokemonPreview pokePreview;
}
