import 'package:pokexplorer/core/common/models/entities/pokemon_type.dart';

class PokemonDetails {
  const PokemonDetails({
    required this.id,
    required this.name,
    required this.imagesUrls,
    required this.height,
    required this.weight,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.types,
    this.cryUrl,
  });

  final int id;
  final String name;
  final List<String> imagesUrls;
  final int height;
  final int weight;
  final int hp;
  final int attack;
  final int defense;
  final String? cryUrl;
  final List<PokemonType> types;
}
