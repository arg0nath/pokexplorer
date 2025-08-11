import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/models/entities/pokemon_type.dart';
import 'package:pokexplorer/core/common/widgets/type_short_card.dart';

class HorizontalTypeList extends StatelessWidget {
  const HorizontalTypeList({super.key, required this.pokemonTypes});

  final List<PokemonType> pokemonTypes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pokemonTypes.length,
        itemBuilder: (BuildContext context, int index) {
          return SelectedTypeContainer.vertical(pokemonType: pokemonTypes[index]);
        },
      ),
    );
  }
}
