import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokexplorer/src/features/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:pokexplorer/src/features/on_boarding/domain/usecases/check_first_timer.dart';

part 'on_boarding_state.dart';

//after setting test, and creating states, now we set cubit and the usecases we gonna need
class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit({
    required CacheFirstTimer cacheFirstTimer,
    required CheckFirstTimer checkFirstTimer,
  }) : _cacheFirstTimer = cacheFirstTimer,
       _checkFirstTimer = checkFirstTimer,
       super(const OnBoardingInitial());

  final CacheFirstTimer _cacheFirstTimer;
  final CheckFirstTimer _checkFirstTimer;

  Future<void> cacheFirstTimer() async {
    emit(const CachingFirstTimer());
    final result = await _cacheFirstTimer();
    result.fold(
      (failure) => emit(OnBoardingError(failure.errorMessage)),
      (_) => emit(const UserCached()),
    );
  }

  Future<void> checkIfUserFirstTimer() async {
    emit(const CheckingIfUserFirstTimer());

    final result = await _checkFirstTimer();
    result.fold(
      (failure) => emit(const OnBoardingStatus(isFirstTimer: true)),
      (status) => emit(OnBoardingStatus(isFirstTimer: status)),
    );
  }
}
