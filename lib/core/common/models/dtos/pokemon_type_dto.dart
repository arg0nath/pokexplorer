import 'dart:convert';

import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/core/common/models/entities/pokemon_type.dart';
import 'package:pokexplorer/core/common/res/app_assets.dart';
import 'package:pokexplorer/core/common/utils/type/get_type_color_by_name.dart';

class PokemonTypeDto extends PokemonType {
  const PokemonTypeDto({
    required super.name,
    required super.icon,
    required super.colorValue,
  });

  factory PokemonTypeDto.fromTypeName(String typeName) {
    return PokemonTypeDto(
      name: typeName,
      icon: getIconForType(typeName),
      colorValue: getColorForType(typeName),
    );
  }

  PokemonTypeDto.fromMap(DataMap map)
      : this(
          name: map['name'] as String,
          icon: getIconForType(map['name'] as String),
          colorValue: getColorForType(map['name'] as String),
        );

  DataMap toMap() => {
        'name': name,
        'icon': icon,
        'colorValue': colorValue,
      };

  String toJson() => jsonEncode(toMap());
  factory PokemonTypeDto.fromJson(String sourceJson) => PokemonTypeDto.fromMap(jsonDecode(sourceJson) as DataMap);

  PokemonType toEntity() {
    return PokemonType(
      colorValue: colorValue,
      name: name,
      icon: icon,
    );
  }
}
