import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/core/common/utils/pokemon/extract_poke_preview_id.dart';
import 'package:pokexplorer/core/common/utils/pokemon/get_poke_image_by_id.dart';
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

extension PokemonPreviewDtoX on PokemonPreviewDto {
  PokemonPreview toEntity({int? idFromDb}) {
    final int id = idFromDb ?? extractPokemonPreviewId(url);
    final String thumbnail = getPokemonBaseImageById(id);
    return PokemonPreview(id: id, name: name, url: thumbnail);
  }
}

extension PokemonPreviewX on PokemonPreview {
  PokemonPreviewDto toDto() {
    final String thumbnail = getPokemonBaseImageById(id);
    return PokemonPreviewDto(name: name, url: thumbnail);
  }
}
