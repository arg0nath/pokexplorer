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

  Future<app_models.PokemonTypeDetails> loadTypeDetails({required String type}) async {
    app_models.PokemonTypeDetails typeDetails = app_models.PokemonTypeDetails.empty();
    final Map<String, dynamic> result = await backendUtils.getTypeDetails(type: type);

    if (result.isNotEmpty) {
      typeDetails = app_models.PokemonTypeDetails.fromJson(result);
    }
    return typeDetails;
  }

  Future<app_models.Pokemon> loadPokemonByName({
    required String name,
  }) async {
    app_models.Pokemon pokemonDetails = app_models.Pokemon.empty();
    final Map<String, dynamic> result = await backendUtils.getPokemonByName(name: name);

    if (result.isNotEmpty) {
      pokemonDetails = app_models.Pokemon.fromJson(result);
    }
    return pokemonDetails;
  }
}
