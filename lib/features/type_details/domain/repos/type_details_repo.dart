import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/features/type_details/domain/entities/type_details.dart';

abstract interface class TypeDetailsRepository {
  const TypeDetailsRepository();

  ResultFuture<TypeDetails> fetchTypeDetails(String typeName);
}
