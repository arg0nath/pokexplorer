import 'package:pokexplorer/core/common/usecase/usecase.dart';
import 'package:pokexplorer/core/utils/typedefs/typedefs.dart';
import 'package:pokexplorer/src/features/on_boarding/domain/repos/on_boarding_repo.dart';

class CheckFirstTimer implements UseCaseWithoutParams<bool> {
  const CheckFirstTimer(this._repository);

  final OnBoardingRepository _repository;

  @override
  ResultFuture<bool> call() async => _repository.checkFirstTimer();
}
