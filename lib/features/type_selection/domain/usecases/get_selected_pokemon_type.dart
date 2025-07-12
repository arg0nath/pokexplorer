import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/config/usecase/usecase.dart';
import 'package:pokexplorer/features/type_selection/domain/repos/pokemon_types_repo.dart';

class GetSelectedPokemonType extends UseCaseWithoutParams<String> {
  const GetSelectedPokemonType(this._userRepository);

  final PokemonTypeRepository _userRepository;

  @override
  ResultFuture<String> call() async => _userRepository.getSelectedPokemonType();
}
