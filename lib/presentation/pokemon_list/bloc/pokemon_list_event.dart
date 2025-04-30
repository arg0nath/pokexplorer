part of 'pokemon_list_bloc.dart';

abstract class PokemonListEvent extends Equatable {
  const PokemonListEvent();

  @override
  List<Object> get props => <Object>[];
}

class LoadPokemonListEvent extends PokemonListEvent {
  const LoadPokemonListEvent({required this.typeDetails});

  final PokemonTypeDetails typeDetails;

  @override
  List<Object> get props => <Object>[typeDetails];
}

class LoadMorePokemonListEvent extends PokemonListEvent {
  const LoadMorePokemonListEvent();

  @override
  List<Object> get props => <Object>[];
}

class NavigateToDetailsFromTypeDetailsEvent extends PokemonListEvent {
  const NavigateToDetailsFromTypeDetailsEvent({required this.pokemonPreview});

  final PokemonPreview pokemonPreview;
  @override
  List<Object> get props => <Object>[pokemonPreview];
}

class UpdateRelationInTypeDetailsEvent extends PokemonListEvent {
  const UpdateRelationInTypeDetailsEvent({required this.pokemonPreview});

  final PokemonPreview pokemonPreview;
  @override
  List<Object> get props => <Object>[pokemonPreview];
}

///`value` is the pokemon name
class SearchPokemonEvent extends PokemonListEvent {
  const SearchPokemonEvent({required this.value});

  final String value;
  @override
  List<Object> get props => <Object>[value];
}

class ReturnFromSearchEvent extends PokemonListEvent {
  const ReturnFromSearchEvent();

  @override
  List<Object> get props => <Object>[];
}

class ExitTypeDetailsEvent extends PokemonListEvent {
  const ExitTypeDetailsEvent();

  @override
  List<Object> get props => <Object>[];
}

class RefreshTypeDetailsEvent extends PokemonListEvent {
  const RefreshTypeDetailsEvent();

  @override
  List<Object> get props => <Object>[];
}
