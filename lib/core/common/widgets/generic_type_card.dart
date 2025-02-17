import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pokexplorer/core/common/constants/app_constants.dart';
import 'package:pokexplorer/core/common/models/app_models.dart';
import 'package:pokexplorer/core/common/utilities/app_utils.dart';
import 'package:pokexplorer/core/common/variables/app_variables.dart';

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
      child: Stack(
        children: [
          // image type + name
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: !pokemonType.isSelected ? typeColor.withAlpha(30) : typeColor.withAlpha(70),
                  borderRadius: BorderRadius.circular(CIRCULAR_RADIUS),
                  border: Border.all(color: pokemonType.isSelected ? typeColor.withAlpha(60) : Theme.of(context).colorScheme.surface)),
              padding: const EdgeInsets.all(10),
              width: logicalWidth * 0.4,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 5,
                  children: [
                    Expanded(flex: 2, child: Image.asset(pokemonType.icon)),
                    Flexible(
                        flex: 1,
                        child: Text(
                          pokemonType.name.toUpperFirst(),
                          style: Theme.of(context).textTheme.labelLarge,
                        )),
                  ],
                ),
              ),
            ),
          ),
          //selected or not - icon
          Positioned(
            bottom: 7,
            right: logicalWidth * 0.06,
            child: (pokemonType.isSelected) ? Icon(Icons.check_circle_outline_rounded, color: typeColor) : const Icon(Icons.circle_outlined, color: Colors.black12),
          ),
        ],
      ),
    ).animate().fade(duration: 300.ms, curve: Curves.easeOutQuad).scale();
  }
}
