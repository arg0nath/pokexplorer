import 'package:fpdart/fpdart.dart';
import 'package:pokexplorer/core/error/failures.dart';
import 'package:pokexplorer/features/type_results/domain/entities/pokemon_preview.dart';

abstract interface class TypeResultsRepository {
  Future<Either<Failure, List<PokemonPreview>>> getPokemonPreviewList({required int typeId});
}
