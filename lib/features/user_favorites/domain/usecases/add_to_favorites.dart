import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/config/usecase/usecase.dart';
import 'package:pokexplorer/features/user_favorites/domain/repo/user_favorites_repo.dart';

class AddToFavorites extends UseCaseWithParams<void, AddToFavoritesParams> {
  const AddToFavorites(this._userFavoritesRepo);

  final UserFavoritesRepo _userFavoritesRepo;

  @override
  ResultFutureVoid call(AddToFavoritesParams params) async => _userFavoritesRepo.addToFavorites(id: params.id, name: params.name);
}

class AddToFavoritesParams {
  const AddToFavoritesParams({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;
}
