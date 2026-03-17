import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';

class OnBoardingCubit extends HydratedCubit<bool> {
  OnBoardingCubit() : super(true); // Default: user is first timer

  /// Mark onboarding as completed
  void completeOnboarding() => emit(false);

  @override
  bool fromJson(DataMap json) => json[AppConst.isFirstTimerKey] as bool? ?? true;

  @override
  DataMap toJson(bool state) => {AppConst.isFirstTimerKey: state};
}
