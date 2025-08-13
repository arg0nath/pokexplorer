import 'package:dartz/dartz.dart';
import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/core/common/errors/exceptions.dart';
import 'package:pokexplorer/core/common/errors/failures.dart';
import 'package:pokexplorer/features/type_details/data/datasource/remote/type_details_remote_data_source.dart';
import 'package:pokexplorer/features/type_details/data/dtos/type_details_dto.dart';
import 'package:pokexplorer/features/type_details/domain/entities/type_details.dart';
import 'package:pokexplorer/features/type_details/domain/repos/type_details_repo.dart';

class TypeDetailsRepoImpl implements TypeDetailsRepository {
  const TypeDetailsRepoImpl(this._remoteDataSource);

  final TypeDetailsRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<TypeDetails> fetchTypeDetails(String typeName) async {
    try {
      final TypeDetailsDto result = await _remoteDataSource.fetchTypeDetails(typeName);
      final TypeDetails entity = result.toEntity();
      return Right(entity);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
