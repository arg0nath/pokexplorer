import 'package:pokexplorer/core/common/usecase/usecase.dart';
import 'package:pokexplorer/core/utils/typedefs/typedefs.dart';
import 'package:pokexplorer/src/features/on_boarding/domain/repos/on_boarding_repo.dart';

class CacheFirstTimer implements UseCaseWithoutParams<void> {
  const CacheFirstTimer(this._repository);

  final OnBoardingRepository _repository;

  @override
  ResultFutureVoid call() async => _repository.cacheFirstTimer();
}
