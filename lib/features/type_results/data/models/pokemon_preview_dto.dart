import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_preview_dto.freezed.dart';
part 'pokemon_preview_dto.g.dart';

@freezed
abstract class PokemonPreviewDto with _$PokemonPreviewDto {
  const factory PokemonPreviewDto({
    required int id,
    required int typeId,
    required String name,
    required String imageUrl,
  }) = _PokemonPreviewDto;

  // Optional: If you want to support JSON serialization
  factory PokemonPreviewDto.fromJson(Map<String, dynamic> json) => _$PokemonPreviewDtoFromJson(json);
}
