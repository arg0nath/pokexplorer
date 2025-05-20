import 'package:pokexplorer/features/type_selection/domain/entities/pokemon_type.dart';

class PokemonTypeDto extends PokemonType {
  PokemonTypeDto({
    required super.name,
    required super.icon,
    required super.isSelected,
  });

  factory PokemonTypeDto.fromDomain(PokemonType type) {
    return PokemonTypeDto(
      name: type.name,
      icon: type.icon,
      isSelected: type.isSelected,
    );
  }
}
