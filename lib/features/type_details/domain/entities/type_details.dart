import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';

abstract class TypeDetails {
  const TypeDetails({
    required this.id,
    required this.name,
    required this.pokemons,
  });

  final int id;
  final String name;
  final List<PokemonPreview> pokemons;
}
