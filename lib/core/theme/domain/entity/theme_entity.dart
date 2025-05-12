enum ThemeType {
  light,
  dark,
}

class ThemeEntity {
  final ThemeType themeType;

  const ThemeEntity({required this.themeType});

  @override
  String toString() {
    return 'ThemeEntity{themeType: $themeType}';
  }
}
