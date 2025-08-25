import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class SettingsLocalDatasource {
  SettingsLocalDatasource();

  // Example method to save theme preference
  Future<void> saveTermsAcceptancePreference(bool value);
  Future<bool> getTermsAcceptancePreference();

  Future<void> saveShowCopyrightedPreference(bool value);
  Future<bool> getShowCopyrightedPreference();
}

// Example method to get theme preference

class SettingsLocalDatasourceImpl implements SettingsLocalDatasource {
  SettingsLocalDatasourceImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  Future<void> saveTermsAcceptancePreference(bool value) async {
    await _sharedPreferences.setBool(AppConst.kAcceptedTermsKey, value);
  }

  @override
  Future<bool> getTermsAcceptancePreference() async {
    final bool? acceptanceValue = _sharedPreferences.getBool(AppConst.kAcceptedTermsKey);
    if (acceptanceValue == null) {
      await _sharedPreferences.setBool(AppConst.kAcceptedTermsKey, false);
      return false;
    }
    return acceptanceValue;
  }

  @override
  Future<void> saveShowCopyrightedPreference(bool value) async {
    await _sharedPreferences.setBool(AppConst.kShowCopyrighted, value);
  }

  @override
  Future<bool> getShowCopyrightedPreference() async {
    final bool? value = _sharedPreferences.getBool(AppConst.kShowCopyrighted);
    if (value == null) {
      await _sharedPreferences.setBool(AppConst.kShowCopyrighted, false);
      return false;
    }
    return value;
  }
}
