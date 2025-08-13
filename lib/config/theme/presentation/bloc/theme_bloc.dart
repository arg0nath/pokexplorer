import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokexplorer/config/theme/domain/entity/theme_entity.dart';
import 'package:pokexplorer/config/theme/domain/usecase/get_theme_usecase.dart';
import 'package:pokexplorer/config/theme/domain/usecase/set_theme_usecase.dart';
import 'package:pokexplorer/core/common/errors/failures.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required GetThemeUseCase getThemeUseCase, required SetThemeUseCase setThemeUseCase})
      : _getThemeUseCase = getThemeUseCase,
        _setThemeUseCase = setThemeUseCase,
        super(ThemeState.initial()) {
    on<GetThemeEvent>(_onGetThemeEvent);
    on<ToggleThemeEvent>(_onToggleThemeEvent);
  }

  Future<void> _onGetThemeEvent(GetThemeEvent event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(status: ThemeStatus.loading));

    try {
      final ThemeEntity result = await _getThemeUseCase();

      emit(state.copyWith(status: ThemeStatus.success, themeEntity: result));
    } catch (e) {
      emit(state.copyWith(status: ThemeStatus.failure, failure: CacheFailure(message: e.toString(), statusCode: 505)));
    }
  }

  Future<void> _onToggleThemeEvent(ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    final ThemeType newTheme = event.isDarkMode ? ThemeType.dark : ThemeType.light;
    final ThemeEntity newThemeEntity = ThemeEntity(themeType: newTheme);
    try {
      await _setThemeUseCase(newThemeEntity);

      emit(state.copyWith(status: ThemeStatus.success, themeEntity: newThemeEntity));
    } catch (e) {
      emit(state.copyWith(status: ThemeStatus.failure, failure: CacheFailure(message: e.toString(), statusCode: 505)));
    }
  }

  final GetThemeUseCase _getThemeUseCase;
  final SetThemeUseCase _setThemeUseCase;
}
