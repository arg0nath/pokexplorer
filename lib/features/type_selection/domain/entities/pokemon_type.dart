import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PokemonType extends Equatable {
  const PokemonType({
    required this.name,
    required this.icon,
    required this.colorValue,
  });
  final String name;
  final String icon;
  final int colorValue;

  const PokemonType.empty()
      : name = '',
        icon = '',
        colorValue = 0xFF000000;

  Color get color => Color(colorValue);

  @override
  List<Object?> get props => [name, icon, colorValue];

  @override
  String toString() {
    return 'PokemonType(name: $name, icon: $icon, color: $color)';
  }
}
