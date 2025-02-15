import 'package:equatable/equatable.dart';

enum ThemeStatus {
  togglingTheme,
  themeToggled,
}

class ThemeState extends Equatable {
  const ThemeState({required this.themeStatus});

  final ThemeStatus themeStatus;

  @override
  List<Object?> get props => <Object?>[themeStatus];
}
