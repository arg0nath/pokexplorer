import '../core/data_repository/back_end_utils.dart';
import '../core/data_repository/local_data_utils.dart';
import '../core/models/app_models.dart' as app_models;

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

  Future<app_models.PokemonTypeDetails> loadTypeDetails({required String type}) async {
    final Map<String, dynamic> tmpResult = await backendUtils.getTypeDetails(type: type);

    final pokeTypeDetails = app_models.PokemonTypeDetails.fromJson(tmpResult);

    return pokeTypeDetails;
  }

  Future<app_models.Pokemon> loadPokemonByName({
    required String name,
  }) async {
    final Map<String, dynamic> tmpResult = await backendUtils.getPokemonByName(name: name);

    final pokemon = app_models.Pokemon.fromJson(tmpResult);

    return pokemon;
  }
}
