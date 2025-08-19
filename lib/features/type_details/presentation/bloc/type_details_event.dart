part of 'type_details_bloc.dart';

abstract class TypeDetailsEvent extends Equatable {
  const TypeDetailsEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class InitialTypeEvent extends TypeDetailsEvent {
  const InitialTypeEvent();
}

class FetchTypeDetailsEvent extends TypeDetailsEvent {
  final String typeName;
  const FetchTypeDetailsEvent(this.typeName);

  @override
  List<Object?> get props => <Object?>[typeName];
}

class ProceedToPokemonDetailsEvent extends TypeDetailsEvent {
  final String pokemonName;
  const ProceedToPokemonDetailsEvent(this.pokemonName);

  @override
  List<Object?> get props => <Object?>[pokemonName];
}

class SearchPokemonsEvent extends TypeDetailsEvent {
  const SearchPokemonsEvent({required this.query});
  final String query;

  @override
  List<Object?> get props => <Object?>[query];
}
