import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/features/pokemon_details/domain/entities/pokemon_details.dart';

part 'pokemon_details_dto.freezed.dart';
part 'pokemon_details_dto.g.dart';

@freezed
abstract class PokemonDetailsDto with _$PokemonDetailsDto {
  const factory PokemonDetailsDto({
    required int id,
    required String name,
  }) = _PokemonDetailsDto;

  factory PokemonDetailsDto.fromJson(DataMap json) => _$PokemonDetailsDtoFromJson(json);
}

extension PokemonPreviewDtoX on PokemonDetailsDto {
  PokemonDetails toEntity() {
    return PokemonDetails(id: id, name: name);
  }
}
