part of 'pokemon_details_bloc.dart';

abstract class PokemonDetailsEvent extends Equatable {
  const PokemonDetailsEvent();
}

class LoadPokemonDetailsEvent extends PokemonDetailsEvent {
  const LoadPokemonDetailsEvent({required this.pokemon});

  final app_models.Pokemon pokemon;

  @override
  List<Object?> get props => <Object>[pokemon];
}

class UpdatePokemonRelationEvent extends PokemonDetailsEvent {
  const UpdatePokemonRelationEvent();

  @override
  List<Object?> get props => <Object>[];
}

class ExitPokemonDetailsEvent extends PokemonDetailsEvent {
  const ExitPokemonDetailsEvent();

  @override
  List<Object?> get props => <Object>[];
}
