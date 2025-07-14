part of 'pokemon_details_bloc.dart';

@freezed
class PokemonDetailsState with _$PokemonDetailsState {
  const factory PokemonDetailsState.initial() = _Initial;
  const factory PokemonDetailsState.loading() = _Loading;
  const factory PokemonDetailsState.loaded(PokemonDetails pokemonDetails) = _Loaded;
  const factory PokemonDetailsState.error(String message) = _Error;
}
