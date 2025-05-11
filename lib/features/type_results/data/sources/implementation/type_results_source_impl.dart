import 'package:pokexplorer/features/type_results/data/models/pokemon_preview_dto.dart';
import 'package:pokexplorer/features/type_results/data/sources/interface/type_results_source_interface.dart';

class TypeResultsSourceImpl implements TypeResultsSourceInterface {
  @override
  Future<List<PokemonPreviewDto>> getPokemonPreviewList({required int typeId}) {
    throw UnimplementedError();
  }
}
