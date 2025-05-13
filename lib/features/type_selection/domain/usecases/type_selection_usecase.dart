import 'package:fpdart/fpdart.dart';
import 'package:pokexplorer/core/error/failures.dart';
import 'package:pokexplorer/core/usecase/no_params.dart';
import 'package:pokexplorer/core/usecase/usecase.dart';
import 'package:pokexplorer/features/type_selection/domain/entities/pokemon_type.dart';
import 'package:pokexplorer/features/type_selection/domain/repositories/type_selection_repo.dart';

class TypeSelectionUsecase implements Usecase<List<PokemonType>, NoParams> {
  TypeSelectionUsecase({required this.typeSelectionRepository});

  final TypeSelectionRepository typeSelectionRepository;

  @override
  Future<Either<Failure, List<PokemonType>>> call({required NoParams params}) async {
    return await typeSelectionRepository.getTypes();
  }
}
