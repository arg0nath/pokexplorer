import 'package:fpdart/fpdart.dart';
import 'package:pokexplorer/core/error/failures.dart';
import 'package:pokexplorer/features/type_results/domain/entities/pokemon_preview.dart';
import 'package:pokexplorer/features/type_results/domain/repositories/type_results_repo.dart';

class TypeResultsImpl implements TypeResultsRepository {
  @override
  Future<Either<Failure, List<PokemonPreview>>> getPokemonPreviewList({required int selectedTypeId}) {
    throw UnimplementedError();
  }
}
