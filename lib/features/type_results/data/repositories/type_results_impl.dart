import 'package:fpdart/fpdart.dart';
import 'package:pokexplorer/core/error/exceptions.dart';
import 'package:pokexplorer/core/error/failures.dart';
import 'package:pokexplorer/features/type_results/data/models/pokemon_preview_dto.dart';
import 'package:pokexplorer/features/type_results/data/sources/interface/type_results_source_interface.dart';
import 'package:pokexplorer/features/type_results/domain/entities/pokemon_preview.dart';
import 'package:pokexplorer/features/type_results/domain/repositories/type_results_repo.dart';

class TypeResultsImpl implements TypeResultsRepository {
  TypeResultsImpl({required this.typeResultsSourceInterface});

  // ! Avoid this:
  // TypeResultsSourceImpl typeResultsSourceImpl = TypeResultsSourceImpl();
  // ? The reason is that we dont need the implementation, we need the interface:
  // ? Because we don't care about how the impl is done. We only care if the method exists or not in our contract

  final TypeResultsSourceInterface typeResultsSourceInterface;

  @override
  Future<Either<Failure, List<PokemonPreview>>> getPokemonPreviewList({required int typeId}) async {
    try {
      final List<PokemonPreviewDto> result = await typeResultsSourceInterface.getPokemonPreviewList(typeId: typeId);

      // Convert PokemonPreviewDto list to PokemonPreview list
      final List<PokemonPreview> pokemonPreviews = result.map((PokemonPreviewDto dto) => PokemonPreview.fromDto(dto)).toList();

      return right(pokemonPreviews);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
