import 'package:equatable/equatable.dart';
import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/config/usecase/usecase.dart';
import 'package:pokexplorer/features/user_favorites/domain/repo/user_favorites_repo.dart';

class RemoveFromFavorites extends UseCaseWithParams<void, RemoveFromFavoritesParams> {
  const RemoveFromFavorites(this._userFavoritesRepo);

  final UserFavoritesRepo _userFavoritesRepo;

  @override
  ResultFutureVoid call(RemoveFromFavoritesParams params) async => _userFavoritesRepo.removeFromFavorites(names: params.names);
}

class RemoveFromFavoritesParams extends Equatable {
  const RemoveFromFavoritesParams({required this.names});

  final List<String> names;

  @override
  List<Object?> get props => [names];
}
