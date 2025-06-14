part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ToggleThemeEvent extends ThemeEvent {
  const ToggleThemeEvent(this.theme);

  final ThemeEntity theme;

  @override
  List<Object> get props => [theme];
}

class GetThemeEvent extends ThemeEvent {
  const GetThemeEvent();

  @override
  List<Object> get props => [];
}
