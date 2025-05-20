import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokexplorer/features/type_selection/domain/entities/pokemon_type.dart';

part 'pokemon_type_dto.freezed.dart';

@freezed
abstract class PokemonTypeDto with _$PokemonTypeDto {
  const factory PokemonTypeDto({
    required String name,
    required String icon,
  }) = _PokemonTypeDto;
}

/// X for extension
extension PokemonTypeDtoX on PokemonTypeDto {
  PokemonType toEntity() {
    return PokemonType(name: name, icon: icon);
  }
}
