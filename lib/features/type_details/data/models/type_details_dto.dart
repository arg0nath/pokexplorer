import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/features/type_details/data/models/pokemon_preview_dto.dart';

part 'type_details_dto.freezed.dart';
part 'type_details_dto.g.dart';

@freezed
abstract class TypeDetailsDto with _$TypeDetailsDto {
  const factory TypeDetailsDto({
    required int id,
    required String name,
    required List<PokemonPreviewDto> pokemons,
  }) = _TypeDetailsDto;

  factory TypeDetailsDto.fromJson(DataMap json) => _$TypeDetailsDtoFromJson(json);
}
