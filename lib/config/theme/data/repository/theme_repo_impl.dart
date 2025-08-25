import 'package:pokexplorer/config/theme/data/datasource/local/theme_local_datasource.dart';
import 'package:pokexplorer/config/theme/domain/entity/theme_entity.dart';
import 'package:pokexplorer/config/theme/domain/repository/theme_repo.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  ThemeRepositoryImpl({required this.themeLocalDatasource});
  final ThemeLocalDataSource themeLocalDatasource;

  @override
  Future<ThemeEntity> getTheme() async {
    return await themeLocalDatasource.getThemePreference();
  }

  @override
  Future<void> setTheme(ThemeEntity theme) async {
    await themeLocalDatasource.saveThemePreference(theme);
  }
}
