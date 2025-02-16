import '../data/local_data_utils.dart';
import '../core/common/utilities/app_utils.dart';
import '../core/common/constants/app_constants.dart';

class LocalDataUtils {
  const LocalDataUtils();

  void saveSelectedTypeNameToPrefs(String typeName) {
    AppUtils.myLog(msg: 'saveSelectedTypeNameToPrefs, typeName = $typeName');
    PreferenceUtils.setString(key: PREFS_SELECTED_TYPE_NAME, value: typeName);
  }

  String loadSelectedTypeNameFromPrefs() {
    return PreferenceUtils.getString(key: PREFS_SELECTED_TYPE_NAME, defValue: EMPTY_STRING);
  }

  bool loadIsInitBootFromPrefs() {
    return PreferenceUtils.getBool(key: PREFS_INIT_BOOT, defValue: true);
  }

  /// responsible for welcome screen. show only in the init boot of the app and never again (ok I know clear cache is an exeption)
  void saveIsInitBootToPrefs(bool initBoot) {
    AppUtils.myLog(msg: 'saveIsInitBootToPrefs, initBoot = $initBoot');
    PreferenceUtils.setBool(key: PREFS_INIT_BOOT, value: initBoot);
  }

  void saveIsDarkModeToPrefs(bool isDarkMode) {
    AppUtils.myLog(msg: 'saveIsDarkModeToPrefs, isDarkMode = $isDarkMode');
    PreferenceUtils.setBool(key: PREFS_IS_DARK_MODE, value: isDarkMode);
  }

  bool loadIsDarkModeFromPrefs() {
    return PreferenceUtils.getBool(key: PREFS_IS_DARK_MODE, defValue: false);
  }
}
