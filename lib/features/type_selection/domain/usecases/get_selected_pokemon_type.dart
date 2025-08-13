import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/config/usecase/usecase.dart';
import 'package:pokexplorer/features/type_selection/domain/repos/type_selection_repo.dart';

class GetSelectedPokemonType extends UseCaseWithoutParams<String> {
  const GetSelectedPokemonType(this._userRepository);

  final TypeSelectionRepository _userRepository;

  @override
  ResultFuture<String> call() async => _userRepository.getSelectedPokemonType();
}
