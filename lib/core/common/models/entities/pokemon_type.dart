import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PokemonType extends Equatable {
  const PokemonType({
    required this.name,
    required this.icon,
    required this.colorValue,
  });
  final String name;
  final String icon;
  final int colorValue;

  Color get color => Color(colorValue);

  @override
  List<Object?> get props => <Object?>[name, icon, colorValue];

  @override
  String toString() {
    return 'PokemonType(name: $name, icon: $icon, color: $color)';
  }
}
