import 'package:equatable/equatable.dart';
import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/config/usecase/usecase.dart';
import 'package:pokexplorer/features/type_details/domain/entities/type_details.dart';
import 'package:pokexplorer/features/type_details/domain/repos/type_details_repo.dart';

class GetTypeDetails extends UseCaseWithParams<TypeDetails, GetTypeDetailsParams> {
  const GetTypeDetails(this._typeDetailsRepository);

  final TypeDetailsRepository _typeDetailsRepository;

  @override
  ResultFuture<TypeDetails> call(GetTypeDetailsParams params) async => _typeDetailsRepository.getTypeDetails(params.typeName);
}

class GetTypeDetailsParams extends Equatable {
  const GetTypeDetailsParams({required this.typeName});

  final String typeName;

  @override
  List<Object?> get props => [typeName];
}
