import 'package:pokexplorer/core/theme/domain/entity/theme_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This class will handle the local data source for theme settings
// It will interact with shared preferences or any local database to store and retrieve theme data
class ThemeLocalDatasource {
  ThemeLocalDatasource({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  // Example method to save theme preference
  Future<void> saveThemePreference(ThemeEntity theme) async {
    String themeValue = theme.themeType == ThemeType.light ? 'light' : 'dark';
    await sharedPreferences.setString('theme_key', themeValue);
  }

  // Example method to get theme preference
  Future<ThemeEntity> getThemePreference() async {
    // Code to retrieve the theme preference from local storage
    final String? themeValue = sharedPreferences.getString('theme_key');
    if (themeValue == null) {
      return const ThemeEntity(themeType: ThemeType.light);
    }
    return ThemeEntity(
      themeType: themeValue == 'light' ? ThemeType.light : ThemeType.dark,
    );
  }
}
