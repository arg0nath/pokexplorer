import 'package:pokexplorer/core/theme/domain/entity/theme_entity.dart';
import 'package:pokexplorer/core/theme/domain/repository/theme_repo.dart';

class SetThemeUseCase {
  SetThemeUseCase(this._themeRepository);

  final ThemeRepository _themeRepository;

  Future<void> call(ThemeEntity themeEntity) async {
    await _themeRepository.setTheme(themeEntity);
  }
}
