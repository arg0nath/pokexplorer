import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokexplorer/core/theme/bloc/theme_state.dart';
import 'package:pokexplorer/core/utilities/app_utils.dart';
import 'package:pokexplorer/core/utilities/front_end_utils.dart';
import 'package:pokexplorer/core/variables/app_variables.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required this.frontEndUtils})
      : super(const ThemeState(
          themeStatus: ThemeStatus.themeToggled,
        )) {
    on<ToggleThemeEvent>((ToggleThemeEvent event, Emitter<ThemeState> emit) async {
      emit(const ThemeState(themeStatus: ThemeStatus.togglingTheme));
      bool tmpIsDarkMode = frontEndUtils.localDataUtils.loadIsDarkModeFromPrefs();
      frontEndUtils.localDataUtils.saveIsDarkModeToPrefs(!tmpIsDarkMode);
      isDarkMode = !tmpIsDarkMode;

      await AppUtils.loadPrefs(frontEndUtils);

      emit(const ThemeState(themeStatus: ThemeStatus.themeToggled));
    });
  }
  late final FrontendUtils frontEndUtils;
}
