import 'package:dartz/dartz.dart';
import 'package:pokexplorer/core/common/errors/exceptions.dart';
import 'package:pokexplorer/core/common/errors/failures.dart';
import 'package:pokexplorer/core/utils/typedefs/typedefs.dart';
import 'package:pokexplorer/src/features/type_selection/data/datasources/local/type_selection_local_datasource.dart';
import 'package:pokexplorer/src/features/type_selection/domain/entities/pokemon_type.dart';
import 'package:pokexplorer/src/features/type_selection/domain/repos/pokemon_types_repo.dart';

class PokemonTypesRepositoryImpl implements PokemonTypeRepository {
  const PokemonTypesRepositoryImpl(this._localDataSource);

  final TypeSelectionLocalDataSource _localDataSource;

  @override
  ResultFuture<List<PokemonType>> getPokemonTypes() async {
    try {
      final List<PokemonType> availableTypes = await _localDataSource.getPokemonTypes();

      return Right(availableTypes);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
