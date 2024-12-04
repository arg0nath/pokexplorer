import '../utilities/app_utils.dart' as app_utils;
import '../variables/app_constants.dart' as app_const;
import '../classes/app_classes.dart' as app_classes;

class LocalDataUtils {
  const LocalDataUtils();

  void saveSelectedTypeNameToPrefs(String typeName) {
    app_utils.myLog(msg: 'saveSelectedTypeNameToPrefs, typeName = $typeName');
    app_classes.PreferenceUtils.setString(key: app_const.PREFS_SELECTED_TYPE_NAME, value: typeName);
  }

  String loadSelectedTypeNameFromPrefs() {
    return app_classes.PreferenceUtils.getString(key: app_const.PREFS_SELECTED_TYPE_NAME, defValue: app_const.EMPTY_STRING);
  }

  bool loadIsInitBootFromPrefs() {
    return app_classes.PreferenceUtils.getBool(key: app_const.PREFS_INIT_BOOT, defValue: true);
  }

  /// responsible for welcome screen. show only in the init boot of the app and never again (ok I know clear cache is an exeption)
  void saveIsInitBootToPrefs(bool initBoot) {
    app_utils.myLog(msg: 'saveIsInitBootToPrefs, initBoot = $initBoot');
    app_classes.PreferenceUtils.setBool(key: app_const.PREFS_INIT_BOOT, value: initBoot);
  }

  void saveIsDarkModeToPrefs(bool isDarkMode) {
    app_utils.myLog(msg: 'saveIsDarkModeToPrefs, isDarkMode = $isDarkMode');
    app_classes.PreferenceUtils.setBool(key: app_const.PREFS_IS_DARK_MODE, value: isDarkMode);
  }

  bool loadIsDarkModeFromPrefs() {
    return app_classes.PreferenceUtils.getBool(key: app_const.PREFS_IS_DARK_MODE, defValue: false);
  }
}
