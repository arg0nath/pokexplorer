import 'package:pokexplorer/config/theme/domain/entity/theme_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This class will handle the local data source for theme settings
// It will interact with shared preferences or any local database to store and retrieve theme data
abstract interface class ThemeLocalDataSource {
  ThemeLocalDataSource({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  // Example method to save theme preference
  Future<void> saveThemePreference(ThemeEntity theme);
  Future<ThemeEntity> getThemePreference();
}

// Example method to get theme preference

class ThemeLocalDatasourceImpl implements ThemeLocalDataSource {
  ThemeLocalDatasourceImpl(this.sharedPreferences);

  @override
  final SharedPreferences sharedPreferences;

  @override
  Future<void> saveThemePreference(ThemeEntity theme) async {
    String themeValue = theme.themeType == ThemeType.light ? 'light' : 'dark';
    await sharedPreferences.setString('theme_key', themeValue);
  }

  @override
  Future<ThemeEntity> getThemePreference() async {
    final String? themeValue = sharedPreferences.getString('theme_key');
    if (themeValue == null) {
      return const ThemeEntity(themeType: ThemeType.light);
    }
    return ThemeEntity(
      themeType: themeValue == 'light' ? ThemeType.light : ThemeType.dark,
    );
  }
}
