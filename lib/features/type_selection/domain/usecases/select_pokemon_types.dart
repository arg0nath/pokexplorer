import 'package:equatable/equatable.dart';
import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/config/usecase/usecase.dart';
import 'package:pokexplorer/features/type_selection/domain/repos/type_selection_repo.dart';

class SelectPokemonType extends UseCaseWithParams<void, SelectedPokemonTypeParams> {
  const SelectPokemonType(this._typeSelectionRepository);

  final TypeSelectionRepository _typeSelectionRepository;

  @override
  ResultFutureVoid call(SelectedPokemonTypeParams params) async => _typeSelectionRepository.selectPokemonType(params.typeName);
}

class SelectedPokemonTypeParams extends Equatable {
  const SelectedPokemonTypeParams({required this.typeName});

  final String typeName;

  @override
  List<Object?> get props => [typeName];
}
