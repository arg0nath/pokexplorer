import 'package:fpdart/fpdart.dart';
import 'package:pokexplorer/core/error/failures.dart';
import 'package:pokexplorer/features/type_selection/data/models/pokemon_type_dto.dart';
import 'package:pokexplorer/features/type_selection/data/sources/local/interface/type_selection_local_data_source_interface.dart';
import 'package:pokexplorer/features/type_selection/domain/entities/pokemon_type.dart';
import 'package:pokexplorer/features/type_selection/domain/repositories/type_selection_repo.dart';

class TypeSelectionImpl implements TypeSelectionRepository {
  TypeSelectionImpl({required this.typeSelectionSource});

  final TypeSelectionLocalSourceInterface typeSelectionSource;

  @override
  Future<Either<Failure, List<PokemonType>>> getTypes() async {
    try {
      final List<PokemonTypeDto> typesDto = await typeSelectionSource.getTypes();
      final List<PokemonType> result = typesDto.map((PokemonTypeDto type) {
        return PokemonType.fromJson(type.toJson());
      }).toList();

      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
