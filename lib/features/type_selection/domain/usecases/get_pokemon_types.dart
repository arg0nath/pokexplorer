import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/config/usecase/usecase.dart';
import 'package:pokexplorer/features/type_selection/domain/repos/type_selection_repo.dart';
import 'package:pokexplorer/core/common/models/entities/pokemon_type.dart';

class GetPokemonTypes extends UseCaseWithoutParams<List<PokemonType>> {
  const GetPokemonTypes(this._userRepository);

  final TypeSelectionRepository _userRepository;

  @override
  ResultFuture<List<PokemonType>> call() async => _userRepository.getPokemonTypes();
}
