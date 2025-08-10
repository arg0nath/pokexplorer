part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ToggleThemeEvent extends ThemeEvent {
  const ToggleThemeEvent(this.isDarkMode);
  final bool isDarkMode;
  @override
  List<Object> get props => [isDarkMode];
}

class GetThemeEvent extends ThemeEvent {
  const GetThemeEvent();

  @override
  List<Object> get props => [];
}
