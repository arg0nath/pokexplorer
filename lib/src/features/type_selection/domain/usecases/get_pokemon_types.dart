import 'package:pokexplorer/core/common/usecase/usecase.dart';
import 'package:pokexplorer/core/utils/typedefs/typedefs.dart';
import 'package:pokexplorer/src/features/type_selection/domain/entities/pokemon_type.dart';
import 'package:pokexplorer/src/features/type_selection/domain/repos/pokemon_types_repo.dart';

class GetPokemonTypes extends UseCaseWithoutParams<List<PokemonType>> {
  const GetPokemonTypes(this._userRepository);

  final PokemonTypeRepository _userRepository;

  @override
  ResultFuture<List<PokemonType>> call() async => _userRepository.getPokemonTypes();
}
