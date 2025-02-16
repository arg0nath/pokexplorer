import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/app_utils.dart';
import '../variables/app_constants.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async => _prefsInstance = await SharedPreferences.getInstance();
  static late SharedPreferences _prefsInstance;

  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    AppUtils.myLog(level: LOG_WARNING, msg: 'Prefs Initialized');
    return _prefsInstance;
  }

  static Future<SharedPreferences> instance() async {
    return _prefsInstance;
  }

  static Future<void> reload() async {
    _prefsInstance = await _instance;
    await _prefsInstance.reload();
    AppUtils.myLog(level: LOG_WARNING, msg: 'Prefs Reload');
  }

  static String getString({required String key, required String defValue}) {
    return _prefsInstance.getString(key) ?? defValue;
  }

  static int getInt({required String key, required int defValue}) {
    return _prefsInstance.getInt(key) ?? defValue;
  }

  static bool getBool({required String key, required bool defValue}) {
    return _prefsInstance.getBool(key) ?? defValue;
  }

  static bool containsKey({required String key}) {
    return _prefsInstance.containsKey(key);
  }

  static Future<bool> setString({required String key, required String value}) async {
    final SharedPreferences prefs = await _instance;
    return prefs.setString(key, value);
  }

  static Future<bool> setInt({required String key, required int value}) async {
    final SharedPreferences prefs = await _instance;
    return prefs.setInt(key, value);
  }

  static Future<bool> setBool({required String key, required bool value}) async {
    final SharedPreferences prefs = await _instance;
    return prefs.setBool(key, value);
  }
}
