import 'package:pokexplorer/features/settings/domain/repo/settings_repo.dart';

class GetTermsOption {
  GetTermsOption(this._repository);

  final SettingsRepo _repository;

  Future<bool> call() async => await _repository.getTermsAcceptancePreference();
}
