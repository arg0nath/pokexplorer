import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/features/pokemon_details/domain/entities/pokemon_details.dart';
import 'package:pokexplorer/features/pokemon_details/presentation/widgets/stat_percent_bar.dart';

class StatContainer extends StatelessWidget {
  const StatContainer({super.key, required this.pokemon});

  final PokemonDetails pokemon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0), // Optional: Adds spacing around the container
      child: Column(
        spacing: 24,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(Icons.scale_rounded),
                  const SizedBox(width: 8),
                  Text(
                    'Weight: ${pokemon.weight}',
                    style: context.theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  const Icon(Icons.straighten),
                  const SizedBox(width: 8),
                  Text(
                    'Height: ${pokemon.height}',
                    style: context.theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          StatPercentBar(type: pokemon.types.first.name, name: 'HP', value: pokemon.hp),
          StatPercentBar(type: pokemon.types.first.name, name: 'ATT', value: pokemon.attack),
          StatPercentBar(type: pokemon.types.first.name, name: 'DEF', value: pokemon.defense),
        ],
      ),
    );
  }
}
