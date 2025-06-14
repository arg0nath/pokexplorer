import 'package:pokexplorer/core/utils/typedefs/typedefs.dart';

abstract interface class OnBoardingRepository {
  const OnBoardingRepository();

  ResultFutureVoid cacheFirstTimer();
  ResultFuture<bool> checkFirstTimer();
}
