part of 'type_details_bloc.dart';

abstract class TypeDetailsEvent extends Equatable {
  const TypeDetailsEvent();

  @override
  List<Object?> get props => [];
}

class InitialTypeEvent extends TypeDetailsEvent {
  const InitialTypeEvent();
}

class FetchTypeDetailsEvent extends TypeDetailsEvent {
  final String typeName;
  const FetchTypeDetailsEvent(this.typeName);

  @override
  List<Object?> get props => [typeName];
}

class ProceedToPokemonDetailsEvent extends TypeDetailsEvent {
  final String pokemonName;
  const ProceedToPokemonDetailsEvent(this.pokemonName);

  @override
  List<Object?> get props => [pokemonName];
}

class SearchPokemonsEvent extends TypeDetailsEvent {
  final String query;
  const SearchPokemonsEvent(this.query);

  @override
  List<Object?> get props => [query];
}
