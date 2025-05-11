// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_preview_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PokemonPreviewDto _$PokemonPreviewDtoFromJson(Map<String, dynamic> json) =>
    _PokemonPreviewDto(
      id: (json['id'] as num).toInt(),
      typeId: (json['typeId'] as num).toInt(),
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$PokemonPreviewDtoToJson(_PokemonPreviewDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typeId': instance.typeId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
    };
