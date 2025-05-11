import 'package:fpdart/fpdart.dart';
import 'package:pokexplorer/core/error/failures.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call({required Params params});
}
