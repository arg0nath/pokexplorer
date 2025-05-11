import 'package:pokexplorer/features/type_results/data/models/pokemon_preview_dto.dart';

//in datasource we're waiting for dtos. No extrernal packages like Either, commands takes place here.

abstract interface class TypeResultsSourceInterface {
  Future<List<PokemonPreviewDto>> getPokemonPreviewList({required int typeId});
}
