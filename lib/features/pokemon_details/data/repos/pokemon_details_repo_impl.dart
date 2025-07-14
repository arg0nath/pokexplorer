import 'package:dartz/dartz.dart';
import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/core/common/errors/exceptions.dart';
import 'package:pokexplorer/core/common/errors/failures.dart';
import 'package:pokexplorer/features/pokemon_details/data/datasource/remote/pokemon_details_remote_data_source.dart';
import 'package:pokexplorer/features/pokemon_details/data/dtos/pokemon_details_dto.dart';
import 'package:pokexplorer/features/pokemon_details/domain/entities/pokemon_details.dart';
import 'package:pokexplorer/features/pokemon_details/domain/repos/pokemon_details_repo.dart';

class PokemonDetailsRepoImpl implements PokemonDetailsRepository {
  const PokemonDetailsRepoImpl(this._remoteDataSource);

  final PokemonDetailsRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<PokemonDetails> fetchPokemonDetails(String name) async {
    try {
      final PokemonDetailsDto result = await _remoteDataSource.fetchPokemonDetails(name);
      final PokemonDetails entity = result.toEntity();
      return Right(entity);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
