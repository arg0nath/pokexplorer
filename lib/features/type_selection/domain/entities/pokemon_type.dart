import 'dart:convert';

class PokemonType {
  PokemonType({
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

  factory PokemonType.fromMap(Map<String, dynamic> map) {
    return PokemonType(
      name: map['name'] as String,
      icon: map['icon'] as String,
      isSelected: map['isSelected'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonType.fromJson(String source) => PokemonType.fromMap(json.decode(source) as Map<String, dynamic>);
}
