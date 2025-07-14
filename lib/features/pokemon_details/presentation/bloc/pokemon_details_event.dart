part of 'pokemon_details_bloc.dart';

@freezed
class PokemonDetailsEvent with _$PokemonDetailsEvent {
  const factory PokemonDetailsEvent.started() = _Started;
  const factory PokemonDetailsEvent.fetchPokemonDetails(final String name) = _FetchPokemonDetails;
}
