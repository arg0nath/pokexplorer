import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/core/common/models/dtos/pokemon_type_dto.dart';
import 'package:pokexplorer/core/common/models/entities/pokemon_type.dart';
import 'package:pokexplorer/core/common/utils/pokemon/get_sprites.dart';
import 'package:pokexplorer/features/pokemon_details/domain/entities/pokemon_details.dart';

part 'pokemon_details_dto.freezed.dart';
// part 'pokemon_details_dto.g.dart';

@freezed
abstract class PokemonDetailsDto with _$PokemonDetailsDto {
  const factory PokemonDetailsDto({
    required int id,
    required String name,
    required String? gifUrl,
    required String baseImageUrl,
    required String hdImageUrl,
    required String? svgUrl,
    required String? secondBaseImageUrl,
    required int height,
    required int weight,
    required int hp,
    required int attack,
    required int defense,
    required String? cryUrl,
    required List<DataMap> types,
  }) = _PokemonDetailsDto;

  /// You must define this manually if you're doing custom logic
  factory PokemonDetailsDto.fromJson(DataMap json) {
    final int id = json['id'] as int;
    final String name = json['name'] as String;
    final String? cryUrl = json['cries']['latest'] as String?;

    final int height = json['height'] as int;
    final int weight = json['weight'] as int;

    final List<dynamic> stats = json['stats'] as List<dynamic>;
    int extractStat(String statName) {
      return stats.firstWhere((s) => s['stat']['name'] == statName)['base_stat'] as int;
    }

    final int hp = extractStat('hp');
    final int attack = extractStat('attack');
    final int defense = extractStat('defense');

    final DataMap sprites = json['sprites'] as DataMap? ?? <String, dynamic>{};
    final DataMap other = sprites['other'] as DataMap? ?? <String, dynamic>{};
    final DataMap officialArtwork = other['official-artwork'] as DataMap? ?? <String, dynamic>{};
    final DataMap showdown = other['showdown'] as DataMap? ?? <String, dynamic>{};

    final String? gifUrl = showdown['front_default'] as String?;
    final String hdImageUrl = officialArtwork['front_default'] as String? ?? '';
    final String baseImageUrl = getPokeBaseImageById(id);
    final String? svgUrl = getPokeSvgById(id);
    final String? secondBaseImageUrl = getPokeBaseSecondImageById(id);

    final List<DataMap> types = (json['types'] as List<dynamic>).map((e) => DataMap.from(e as Map)).toList();

    return PokemonDetailsDto(
      id: id,
      name: name,
      gifUrl: gifUrl,
      baseImageUrl: baseImageUrl,
      svgUrl: svgUrl,
      secondBaseImageUrl: secondBaseImageUrl,
      hdImageUrl: hdImageUrl,
      height: height,
      weight: weight,
      hp: hp,
      cryUrl: cryUrl,
      attack: attack,
      defense: defense,
      types: types,
    );
  }
}

extension PokemonDetailsDtoX on PokemonDetailsDto {
  PokemonDetails toEntity() {
    final List<PokemonType> mappedTypes = types.map((DataMap typeMap) => PokemonTypeDto.fromMap(typeMap['type'] as DataMap)).toList();

    final List<String> imagesUrls = <String>[
      hdImageUrl,
      svgUrl ?? '',
      secondBaseImageUrl ?? '',
      baseImageUrl,
      gifUrl ?? '',
    ].where((String url) => url.isNotEmpty).toList();

    return PokemonDetails(
      id: id,
      name: name,
      imagesUrls: imagesUrls,
      height: height,
      weight: weight,
      hp: hp,
      cryUrl: cryUrl,
      attack: attack,
      defense: defense,
      types: mappedTypes,
    );
  }
}
