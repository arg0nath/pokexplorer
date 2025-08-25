import 'package:pokexplorer/features/settings/domain/repo/settings_repo.dart';

class SetTermsOption {
  const SetTermsOption(this._repository);

  final SettingsRepo _repository;

  Future<void> call(bool value) async => await _repository.saveTermsAcceptancePreference(value);
}
