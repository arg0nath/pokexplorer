import 'package:pokexplorer/config/theme/domain/entity/theme_entity.dart';

abstract interface class ThemeRepository {
  Future<ThemeEntity> getTheme();
  Future<void> setTheme(ThemeEntity theme);
}
