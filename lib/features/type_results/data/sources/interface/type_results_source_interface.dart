import 'package:pokexplorer/features/type_results/data/models/pokemon_preview_dto.dart';

abstract interface class TypeResultsSourceInterface {
  Future<List<PokemonPreviewDto>> getPokemonPreviewList({required int typeId});
}
