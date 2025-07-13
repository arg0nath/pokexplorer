import 'package:pokexplorer/features/type_details/data/models/type_details_dto.dart';

abstract interface class TypeDetailsRemoteDataSource {
  Future<TypeDetailsDto> getTypeDetails(String typeName);
}

class TypeDetailsRemoteDataSourceImpl implements TypeDetailsRemoteDataSource {
  const TypeDetailsRemoteDataSourceImpl();

  @override
  Future<TypeDetailsDto> getTypeDetails(String typeName) {
    throw UnimplementedError();
  }
}
