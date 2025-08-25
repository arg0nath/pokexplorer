import 'package:pokexplorer/features/settings/domain/repo/settings_repo.dart';

class GetCopyrightOption {
  GetCopyrightOption(this._repository);

  final SettingsRepo _repository;

  Future<bool> call() async => await _repository.getShowCopyrightedPreference();
}
