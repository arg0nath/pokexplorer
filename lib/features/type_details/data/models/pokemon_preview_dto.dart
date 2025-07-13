import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/core/common/utils/type/pokemon_type.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';

part 'pokemon_preview_dto.freezed.dart';
part 'pokemon_preview_dto.g.dart';

@freezed
abstract class PokemonPreviewDto with _$PokemonPreviewDto {
  const factory PokemonPreviewDto({
    required String url,
    required String name,
  }) = _PokemonPreviewDto;

  factory PokemonPreviewDto.fromJson(DataMap json) => _$PokemonPreviewDtoFromJson(json);
}

PokemonPreview toPokemonPreview(PokemonPreviewDto dto) {
  final int id = extractPokemonPreviewId(dto.url);
  final String thumbnail = getPokemonBaseImageById(id);
  return PokemonPreview(
    id: id,
    name: dto.name,
    thumbnail: thumbnail,
  );
}
