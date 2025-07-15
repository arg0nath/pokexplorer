import 'package:pokexplorer/shared/entities/pokemon_type.dart';

class PokemonDetails {
  const PokemonDetails({
    required this.id,
    required this.name,
    required this.gifUrl,
    required this.hdImageUrl,
    required this.baseImageUrl,
    required this.height,
    required this.weight,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.types,
  });

  final int id;
  final String name;
  final String? gifUrl;
  final String baseImageUrl;
  final String hdImageUrl;
  final int height;
  final int weight;
  final int hp;
  final int attack;
  final int defense;
  final List<PokemonType> types;
}
