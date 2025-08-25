import 'package:pokexplorer/features/settings/domain/repo/settings_repo.dart';

class SetCopyrightOption {
  const SetCopyrightOption(this._repository);

  final SettingsRepo _repository;

  Future<void> call(bool value) async => await _repository.saveShowCopyrightedPreference(value);
}
