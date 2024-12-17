part of 'type_details_bloc.dart';

abstract class TypeDetailsEvent extends Equatable {
  const TypeDetailsEvent();

  @override
  List<Object> get props => <Object>[];
}

class LoadTypeDetailsPokemonsEvent extends TypeDetailsEvent {
  const LoadTypeDetailsPokemonsEvent({required this.typeDetails});

  final app_models.PokemonTypeDetails typeDetails;

  @override
  List<Object> get props => <Object>[typeDetails];
}

class LoadMoreTypeDetailsPokemonsEvent extends TypeDetailsEvent {
  const LoadMoreTypeDetailsPokemonsEvent();

  @override
  List<Object> get props => <Object>[];
}

class NavigateToDetailsFromTypeDetailsEvent extends TypeDetailsEvent {
  const NavigateToDetailsFromTypeDetailsEvent({required this.pokemonPreview});

  final app_models.PokemonPreview pokemonPreview;
  @override
  List<Object> get props => <Object>[pokemonPreview];
}

class UpdateRelationInTypeDetailsEvent extends TypeDetailsEvent {
  const UpdateRelationInTypeDetailsEvent({required this.pokemonPreview});

  final app_models.PokemonPreview pokemonPreview;
  @override
  List<Object> get props => <Object>[pokemonPreview];
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

class RefreshTypeDetailsEvent extends TypeDetailsEvent {
  const RefreshTypeDetailsEvent();

  @override
  List<Object> get props => <Object>[];
}
