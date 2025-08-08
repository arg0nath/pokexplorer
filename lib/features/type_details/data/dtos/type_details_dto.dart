import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokexplorer/config/logger/my_log.dart';
import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/features/type_details/data/dtos/pokemon_preview_dto.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';
import 'package:pokexplorer/features/type_details/domain/entities/type_details.dart';

part 'type_details_dto.freezed.dart';
part 'type_details_dto.g.dart';

@freezed
abstract class TypeDetailsDto with _$TypeDetailsDto {
  const factory TypeDetailsDto({
    required int id,
    required String name,
    required List<DataMap> pokemon,
  }) = _TypeDetailsDto;

  factory TypeDetailsDto.fromJson(DataMap json) => _$TypeDetailsDtoFromJson(json);
}

extension TypeDetailsDtoX on TypeDetailsDto {
  TypeDetails toEntity() {
    final List<PokemonPreview> pokemons = pokemon.map((DataMap entry) => PokemonPreviewDto.fromJson(entry['pokemon'] as DataMap).toEntity()).toList();
    myLog('Converted TypeDetailsDto to TypeDetails: id=$id, name=$name, pokemons=${pokemons}');
    return TypeDetails(
      id: id,
      name: name,
      pokemons: pokemons,
    );
  }
}
