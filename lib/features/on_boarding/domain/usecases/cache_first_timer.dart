import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/config/usecase/usecase.dart';
import 'package:pokexplorer/features/on_boarding/domain/repos/on_boarding_repo.dart';

class CacheFirstTimer implements UseCaseWithoutParams<void> {
  const CacheFirstTimer(this._repository);

  final OnBoardingRepository _repository;

  @override
  ResultFutureVoid call() async => _repository.cacheFirstTimer();
}
