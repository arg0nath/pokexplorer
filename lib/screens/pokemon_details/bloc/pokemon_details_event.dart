part of 'pokemon_details_bloc.dart';

abstract class PokemonDetailsEvent extends Equatable {
  const PokemonDetailsEvent();
}

class LoadPokemonDetailsEvent extends PokemonDetailsEvent {
  const LoadPokemonDetailsEvent({required this.name});

  final String name;

  @override
  List<Object?> get props => <Object>[name];
}
