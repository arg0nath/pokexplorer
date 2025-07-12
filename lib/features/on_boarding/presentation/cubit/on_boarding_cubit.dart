import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pokexplorer/core/common/errors/failures.dart';
import 'package:pokexplorer/features/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:pokexplorer/features/on_boarding/domain/usecases/check_first_timer.dart';

part 'on_boarding_state.dart';

//after setting test, and creating states, now we set cubit and the usecases we gonna need
class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit({
    required CacheFirstTimer cacheFirstTimer,
    required CheckFirstTimer checkFirstTimer,
  })  : _cacheFirstTimer = cacheFirstTimer,
        _checkFirstTimer = checkFirstTimer,
        super(const OnBoardingInitial());

  final CacheFirstTimer _cacheFirstTimer;
  final CheckFirstTimer _checkFirstTimer;

  Future<void> cacheFirstTimer() async {
    emit(const CachingFirstTimer());
    final Either<Failure, void> result = await _cacheFirstTimer();
    log('cacheFirstTimer result: $result');
    result.fold(
      (Failure failure) => emit(OnBoardingError(failure.errorMessage)),
      (_) => emit(const UserCached()),
    );
  }

  Future<void> checkIfUserFirstTimer() async {
    emit(const CheckingIfUserFirstTimer());

    final Either<Failure, bool> result = await _checkFirstTimer();
    log('checkIfUserFirstTimer result: $result');

    result.fold(
      (Failure failure) => emit(const OnBoardingStatus(isFirstTimer: true)),
      (bool status) => emit(OnBoardingStatus(isFirstTimer: status)),
    );
  }
}
