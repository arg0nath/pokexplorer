import 'package:pokexplorer/src/utilities/app_utils.dart' as app_utils;
import 'package:pokexplorer/src/variables/app_constants.dart' as app_const;

import '../data_repository/back_end_utils.dart';
import '../data_repository/local_data_utils.dart';
import '../models/app_models.dart' as app_models;

class FrontendUtils {
  FrontendUtils() {
    backendUtils = BackendUtils();
    localDataUtils = const LocalDataUtils();
  }

  late final BackendUtils backendUtils;
  late final LocalDataUtils localDataUtils;

  String loadSelectedTypeName() => localDataUtils.loadSelectedTypeNameFromPrefs();

  void saveSelectedTypeName(String typeName) {
    localDataUtils.saveSelectedTypeNameToPrefs(typeName);
  }

  Future<dynamic> loadTypeDetails({required String type}) async {
    dynamic result;

    final Map<String, dynamic> tmpResult = await backendUtils.getTypeDetails(type: type);

    if (tmpResult.containsKey('error')) {
      app_utils.myLog(app_const.LOG_ERROR, 'Error fetching type details: ${tmpResult['error']}');
      return app_models.MyError(name: (tmpResult['error'] as String).replaceFirstMapped('Exception:', (match) => app_const.EMPTY_STRING));
    }

    result = app_models.PokemonTypeDetails.fromJson(tmpResult);

    return result;
  }

  Future<dynamic> loadPokemonByName({
    required String name,
  }) async {
    dynamic result;

    final Map<String, dynamic> tmpResult = await backendUtils.getPokemonByName(name: name);

    if (tmpResult.containsKey('error')) {
      app_utils.myLog(app_const.LOG_ERROR, 'Error fetching Pokémon details: ${tmpResult['error']}');
      return app_models.MyError(name: (tmpResult['error'] as String).replaceFirstMapped('Exception:', (match) => app_const.EMPTY_STRING));
    }

    result = app_models.Pokemon.fromJson(tmpResult);

    return result;
  }
}
