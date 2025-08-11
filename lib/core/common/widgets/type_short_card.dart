import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/extensions/string_ext.dart';
import 'package:pokexplorer/core/common/models/entities/pokemon_type.dart';

class SelectedTypeContainer extends StatelessWidget {
  final PokemonType pokemonType;

  final bool isVertical;

  const SelectedTypeContainer._({
    required this.pokemonType,
    this.isVertical = false,
    super.key,
  });

  factory SelectedTypeContainer({required PokemonType pokemonType, Key? key}) {
    return SelectedTypeContainer._(pokemonType: pokemonType, key: key);
  }

  factory SelectedTypeContainer.vertical({required PokemonType pokemonType, Key? key}) {
    return SelectedTypeContainer._(pokemonType: pokemonType, isVertical: true, key: key);
  }

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(pokemonType.icon, height: 24, width: 24),
                  const SizedBox(width: 8),
                  Text(
                    pokemonType.name.toUpperFirst(),
                    style: context.theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ]),
        ),
      );
    }

    // Default horizontal layout
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(pokemonType.icon, height: 30, width: 30),
        const SizedBox(width: 10),
        Text(
          pokemonType.name.toUpperFirst(),
          textAlign: TextAlign.center,
          style: context.theme.appBarTheme.titleTextStyle?.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
