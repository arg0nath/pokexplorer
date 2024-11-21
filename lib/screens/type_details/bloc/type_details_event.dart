part of 'type_details_bloc.dart';

abstract class TypeDetailsEvent extends Equatable {
  const TypeDetailsEvent();

  @override
  List<Object> get props => <Object>[];
}

class LoadTypeDetailsPokemonsEvent extends TypeDetailsEvent {
  const LoadTypeDetailsPokemonsEvent({required this.typeName});

  final String typeName;

  @override
  List<Object> get props => <Object>[typeName];
}

class LoadMoreTypeDetailsPokemonsEvent extends TypeDetailsEvent {
  const LoadMoreTypeDetailsPokemonsEvent();

  @override
  List<Object> get props => <Object>[];
}

class NavigateToPokemonDetailsEvent extends TypeDetailsEvent {
  const NavigateToPokemonDetailsEvent({required this.pokemon});

  final app_models.Pokemon pokemon;
  @override
  List<Object> get props => <Object>[pokemon];
}

///`value` is the pokemon name
class SearchPokemonEvent extends TypeDetailsEvent {
  const SearchPokemonEvent({required this.value});

  final String value;
  @override
  List<Object> get props => <Object>[value];
}

class ReturnFromSearchEvent extends TypeDetailsEvent {
  const ReturnFromSearchEvent();

  @override
  List<Object> get props => <Object>[];
}

class ExitTypeDetailsEvent extends TypeDetailsEvent {
  const ExitTypeDetailsEvent();

  @override
  List<Object> get props => <Object>[];
}
