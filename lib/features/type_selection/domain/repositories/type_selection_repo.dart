import 'package:fpdart/fpdart.dart';
import 'package:pokexplorer/core/error/failures.dart';
import 'package:pokexplorer/features/type_selection/domain/entities/pokemon_type.dart';

abstract interface class TypeSelectionRepository {
  Future<Either<Failure, List<PokemonType>>> getTypes();
}
