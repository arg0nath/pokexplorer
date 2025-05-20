import 'package:fpdart/fpdart.dart';
import 'package:pokexplorer/core/error/failures.dart';
import 'package:pokexplorer/core/usecase/no_params.dart';
import 'package:pokexplorer/core/usecase/usecase.dart';
import 'package:pokexplorer/features/type_selection/data/models/pokemon_type_dto.dart';
import 'package:pokexplorer/features/type_selection/data/sources/type_selection_local_source.dart';
import 'package:pokexplorer/features/type_selection/domain/entities/pokemon_type.dart';

class GetLocalPokemonTypesUseCase implements Usecase<List<PokemonType>, NoParams> {
  final TypeSelectionLocalSourceInterface localSource;

  GetLocalPokemonTypesUseCase(this.localSource);

  @override
  Future<Either<Failure, List<PokemonType>>> call({required NoParams params}) async {
    try {
      final List<PokemonTypeDto> dtos = await localSource.getTypes();
      final List<PokemonType> entities = dtos.map((PokemonTypeDto dto) => dto.toEntity()).toList();
      return right(entities);
    } catch (e) {
      return left(Failure('Failed to load local types'));
    }
  }
}
