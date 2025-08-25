import 'package:pokexplorer/features/settings/data/datasources/local/settings_local_datasource.dart';
import 'package:pokexplorer/features/settings/domain/repo/settings_repo.dart';

class SettingsRepoImpl implements SettingsRepo {
  const SettingsRepoImpl(this._settingsLocalDatasource);

  final SettingsLocalDatasource _settingsLocalDatasource;

  @override
  Future<bool> getTermsAcceptancePreference() async {
    return await _settingsLocalDatasource.getTermsAcceptancePreference();
  }

  @override
  Future<void> saveTermsAcceptancePreference(bool value) async {
    await _settingsLocalDatasource.saveTermsAcceptancePreference(value);
  }

  @override
  Future<bool> getShowCopyrightedPreference() async {
    return await _settingsLocalDatasource.getShowCopyrightedPreference();
  }

  @override
  Future<void> saveShowCopyrightedPreference(bool value) async {
    await _settingsLocalDatasource.saveShowCopyrightedPreference(value);
  }
}
