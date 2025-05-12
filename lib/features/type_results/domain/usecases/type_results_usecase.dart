import 'package:fpdart/fpdart.dart';
import 'package:pokexplorer/core/error/failures.dart';
import 'package:pokexplorer/features/type_results/domain/entities/pokemon_preview.dart';
import 'package:pokexplorer/features/type_results/domain/repositories/type_results_repo.dart';

import '../../../../core/usecase/usecase.dart';

class TypeResultsUsecase implements Usecase<List<PokemonPreview>, TypeResultsParams> {
  TypeResultsUsecase({required this.typeResultsRepository});
  final TypeResultsRepository typeResultsRepository;

  @override
  Future<Either<Failure, List<PokemonPreview>>> call({required TypeResultsParams params}) async {
    return await typeResultsRepository.getPokemonPreviewList(typeId: params.typeId);
    //rivaan 01:56:50
  }
}

class TypeResultsParams {
  TypeResultsParams({required this.typeId});
  final int typeId;
}
