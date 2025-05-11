import 'package:pokexplorer/features/type_results/data/models/pokemon_preview_dto.dart';
import 'package:pokexplorer/features/type_results/data/sources/interface/type_results_source_interface.dart';

import '../../../../../core/error/exceptions.dart';

//in datasource we're waiting for dtos. No extrernal packages,dependecies  like Either, commands takes place here.

class TypeResultsSourceImpl implements TypeResultsSourceInterface {
  @override
  Future<List<PokemonPreviewDto>> getPokemonPreviewList({required int typeId}) async {
    try {
      final List<PokemonPreviewDto>? result = await Future.value(<PokemonPreviewDto>[]);
      if (result == null) throw ServerException(message: 'List is null');
      return result;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
