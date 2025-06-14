import 'package:pokexplorer/config/theme/domain/entity/theme_entity.dart';
import 'package:pokexplorer/config/theme/domain/repository/theme_repo.dart';

class GetThemeUseCase {
  GetThemeUseCase(this._themeRepository);

  final ThemeRepository _themeRepository;

  Future<ThemeEntity> call() async {
    return await _themeRepository.getTheme();
  }
}
