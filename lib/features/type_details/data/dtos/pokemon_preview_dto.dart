import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/utils/pokemon/extract_poke_preview_id.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';

part 'pokemon_preview_dto.freezed.dart';
part 'pokemon_preview_dto.g.dart';

@freezed
abstract class PokemonPreviewDto extends PokemonPreview with _$PokemonPreviewDto {
  const PokemonPreviewDto._()
      : super(
          id: AppConst.emptyInt,
          url: AppConst.emptyString,
          name: AppConst.emptyString,
        );

  const factory PokemonPreviewDto({
    required String url,
    required String name,
  }) = _PokemonPreviewDto;

  factory PokemonPreviewDto.fromJson(DataMap json) => _$PokemonPreviewDtoFromJson(json);

  PokemonPreview toEntity() {
    return PokemonPreview(id: extractPokemonPreviewId(url), name: name, url: url);
  }

  static PokemonPreviewDto fromEntity(PokemonPreview entity) {
    return PokemonPreviewDto(
      name: entity.name,
      url: entity.url,
    );
  }
}
