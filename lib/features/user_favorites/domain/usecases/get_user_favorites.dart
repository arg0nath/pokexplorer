import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/config/usecase/usecase.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';
import 'package:pokexplorer/features/user_favorites/domain/repo/user_favorites_repo.dart';

class GetUserFavorites extends UseCaseWithoutParams<List<PokemonPreview>> {
  const GetUserFavorites(this._userFavoritesRepo);

  final UserFavoritesRepo _userFavoritesRepo;

  @override
  ResultFuture<List<PokemonPreview>> call() async => _userFavoritesRepo.getUserFavorites();
}
