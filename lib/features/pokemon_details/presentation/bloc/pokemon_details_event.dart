part of 'pokemon_details_bloc.dart';

abstract class PokemonDetailsEvent extends Equatable {
  const PokemonDetailsEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class InitialPokeDetailsEvent extends PokemonDetailsEvent {
  const InitialPokeDetailsEvent();
}

class FetchPokemonDetailsEvent extends PokemonDetailsEvent {
  final String name;
  const FetchPokemonDetailsEvent(this.name);

  @override
  List<Object?> get props => <Object?>[name];
}
