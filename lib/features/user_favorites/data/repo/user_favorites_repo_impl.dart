import 'package:dartz/dartz.dart';
import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/core/common/errors/exceptions.dart';
import 'package:pokexplorer/core/common/errors/failures.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';
import 'package:pokexplorer/features/user_favorites/data/datasources/local/user_favorites_local_datasource.dart';

import '../../domain/repo/user_favorites_repo.dart';

class UserFavoritesRepoImpl implements UserFavoritesRepo {
  const UserFavoritesRepoImpl(this._localDataSource);

  final UserFavoritesLocalDatasource _localDataSource;

  @override
  ResultFuture<List<PokemonPreview>> getUserFavorites() async {
    try {
      final List<PokemonPreview> result = await _localDataSource.getUserFavoritesFromDb();
      return Right<Failure, List<PokemonPreview>>(result);
    } on CacheException catch (e) {
      return Left<Failure, List<PokemonPreview>>(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFutureVoid addToFavorites({required int id, required String name}) async {
    try {
      await _localDataSource.addToFavoritesDb(
        id: id,
        name: name,
      );
      return const Right<Failure, void>(null);
    } on CacheException catch (e) {
      return Left<Failure, void>(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFutureVoid removeFromFavorites({required List<String> names}) async {
    try {
      if (names.isEmpty) {
        await _localDataSource.deleteUserFavoritesFromDb();
        return const Right<Failure, void>(null);
      }

      for (final String name in names) {
        await _localDataSource.removeFromFavoritesDb(name: name);
      }

      return const Right<Failure, void>(null);
    } on CacheException catch (e) {
      return Left<Failure, void>(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
