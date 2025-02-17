import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pokexplorer/core/common/models/app_models.dart';
import 'package:pokexplorer/core/common/utilities/app_utils.dart';

class GenericTypeCard extends StatelessWidget {
  const GenericTypeCard({
    super.key,
    required this.onTap,
    required this.pokemonType,
  });

  final PokemonType pokemonType;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final typeColor = AppUtils.getTypeColor(pokemonType.name);
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: !pokemonType.isSelected ? typeColor.withAlpha(40) : typeColor.withAlpha(70),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pokemonType.name.toUpperFirst(),
                style: Theme.of(context).textTheme.labelLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    pokemonType.icon,
                    fit: BoxFit.scaleDown,
                  ),
                  (pokemonType.isSelected)
                      ? Icon(Icons.check_circle_outline_rounded, size: 20, color: typeColor)
                      : Icon(Icons.circle_outlined, size: 20, color: Theme.of(context).colorScheme.primary.withAlpha(50)),
                ],
              ),
            ],
          ),
        ),
      ),
    ).animate().fade(duration: 300.ms, curve: Curves.easeOutQuad).scale();
  }
}

/* 
 Container(
          decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(CIRCULAR_RADIUS),
              border: Border.all(color: pokemonType.isSelected ? typeColor.withAlpha(60) : Theme.of(context).colorScheme.surface)),
          padding: const EdgeInsets.all(10),
          width: logicalWidth * 0.4,
          child: Column(
            children: [
              Image.asset(pokemonType.icon),
              Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: Text(
                        pokemonType.name.toUpperFirst() + 'adsasd jkasdjasjdh',
                        style: Theme.of(context).textTheme.labelLarge,
                      )),
                  (pokemonType.isSelected) ? Icon(Icons.check_circle_outline_rounded, color: typeColor) : Icon(Icons.circle_outlined, color: Theme.of(context).colorScheme.primary.withAlpha(50)),
                ],
              ),
            ],
          )), */
