import 'package:dartz/dartz.dart';
import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/core/common/errors/exceptions.dart';
import 'package:pokexplorer/core/common/errors/failures.dart';
import 'package:pokexplorer/features/type_selection/data/datasources/local/type_selection_local_datasource.dart';
import 'package:pokexplorer/features/type_selection/domain/entities/pokemon_type.dart';
import 'package:pokexplorer/features/type_selection/domain/repos/type_selection_repo.dart';

class TypeSelectionRepositoryImpl implements TypeSelectionRepository {
  const TypeSelectionRepositoryImpl(this._localDataSource);

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

  @override
  ResultFutureVoid selectPokemonType(String typeName) async {
    try {
      final result = await _localDataSource.selectPokemonType(typeName);

      return Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<String> getSelectedPokemonType() async {
    try {
      final String selectedTypeName = await _localDataSource.getSelectedType();

      return Right(selectedTypeName);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
