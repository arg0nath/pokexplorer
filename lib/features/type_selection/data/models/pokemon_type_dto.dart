import 'dart:convert';

class PokemonTypeDto {
  PokemonTypeDto({
    required this.name,
    required this.icon,
    required this.isSelected,
  });

  final String name;
  final String icon;

  final bool isSelected;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'icon': icon,
      'isSelected': isSelected,
    };
  }

  factory PokemonTypeDto.fromMap(Map<String, dynamic> map) {
    return PokemonTypeDto(
      name: map['name'] as String,
      icon: map['icon'] as String,
      isSelected: map['isSelected'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonTypeDto.fromJson(String source) => PokemonTypeDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
