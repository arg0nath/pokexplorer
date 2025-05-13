part of 'type_selection_bloc.dart';

sealed class TypeSelectionState extends Equatable {
  const TypeSelectionState();

  @override
  List<Object> get props => [];
}

final class TypeSelectionInitial extends TypeSelectionState {
  const TypeSelectionInitial();

  @override
  List<Object> get props => [];
}

final class LoadingPokemonTypes extends TypeSelectionState {
  const LoadingPokemonTypes();

  @override
  List<Object> get props => [];
}

final class PokemonTypesLoaded extends TypeSelectionState {
  const PokemonTypesLoaded(this.pokemonTypes);
  final List<PokemonType> pokemonTypes;
  @override
  List<Object> get props => [pokemonTypes];
}

final class PokemonTypesFailure extends TypeSelectionState {
  const PokemonTypesFailure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
