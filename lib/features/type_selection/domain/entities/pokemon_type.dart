import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_type.freezed.dart';

@freezed
abstract class PokemonType with _$PokemonType {
  const factory PokemonType({
    required String name,
    required String icon,
  }) = _PokemonType;
}
