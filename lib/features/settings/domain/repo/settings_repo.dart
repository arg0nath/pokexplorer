abstract class SettingsRepo {
  const SettingsRepo();

  Future<bool> getTermsAcceptancePreference();
  Future<void> saveTermsAcceptancePreference(bool value);
  Future<bool> getShowCopyrightedPreference();
  Future<void> saveShowCopyrightedPreference(bool value);
}
