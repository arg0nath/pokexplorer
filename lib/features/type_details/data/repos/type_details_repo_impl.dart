import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/features/type_details/domain/entities/type_details.dart';
import 'package:pokexplorer/features/type_details/domain/repos/type_details_repo.dart';

class TypeDetailsRepoImpl implements TypeDetailsRepository {
  @override
  ResultFuture<TypeDetails> getTypeDetails(String typeName) async {
    throw UnimplementedError();
  }
}
