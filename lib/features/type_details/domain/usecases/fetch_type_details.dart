import 'package:equatable/equatable.dart';
import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/config/usecase/usecase.dart';
import 'package:pokexplorer/features/type_details/domain/entities/type_details.dart';
import 'package:pokexplorer/features/type_details/domain/repos/type_details_repo.dart';

class FetchTypeDetails extends UseCaseWithParams<TypeDetails, FetchTypeDetailsParams> {
  const FetchTypeDetails(this._typeDetailsRepository);

  final TypeDetailsRepository _typeDetailsRepository;

  @override
  ResultFuture<TypeDetails> call(FetchTypeDetailsParams params) async => _typeDetailsRepository.fetchTypeDetails(params.typeName);
}

class FetchTypeDetailsParams extends Equatable {
  const FetchTypeDetailsParams({required this.typeName});

  final String typeName;

  @override
  List<Object?> get props => [typeName];
}
