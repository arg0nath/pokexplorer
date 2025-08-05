import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/config/usecase/usecase.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';
import 'package:pokexplorer/features/user_favorites/domain/repo/user_favorites_repo.dart';

class AddToFavorites extends UseCaseWithParams<void, PokemonPreview> {
  const AddToFavorites(this._userFavoritesRepo);

  final UserFavoritesRepo _userFavoritesRepo;

  @override
  ResultFutureVoid call(PokemonPreview pokemon) async => _userFavoritesRepo.addToFavorites(pokemon: pokemon);
}
