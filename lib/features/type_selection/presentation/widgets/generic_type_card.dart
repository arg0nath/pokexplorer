import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/extensions/string_ext.dart';
import 'package:pokexplorer/core/common/models/entities/pokemon_type.dart';

class GenericTypeCard extends StatelessWidget {
  const GenericTypeCard({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.pokemonType,
  });

  final PokemonType pokemonType;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final int typeColor = pokemonType.colorValue;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        borderOnForeground: true,
        color: !isSelected ? Color(typeColor).withAlpha(40) : Color(typeColor).withAlpha(190),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  pokemonType.name.toUpperFirst(),
                  style: context.theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    pokemonType.icon,
                    height: 100,
                    fit: BoxFit.scaleDown,
                  ),
                  (isSelected)
                      ? Icon(
                          Icons.radio_button_checked_rounded,
                          size: 25,
                          color: context.theme.iconTheme.color?.withAlpha(100),
                        )
                      : Icon(
                          Icons.circle_outlined,
                          size: 25,
                          color: context.theme.iconTheme.color?.withAlpha(80),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).animate().fade(duration: 300.ms, curve: Curves.easeOutQuad).scale();
  }
}
