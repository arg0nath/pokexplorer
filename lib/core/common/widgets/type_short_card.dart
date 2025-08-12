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
      return Container(
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          border: Border.all(color: context.theme.colorScheme.onSurface.withAlpha(40), width: .5),
          color: context.theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: context.theme.shadowColor,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double iconHeight = constraints.maxHeight * 0.45;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: iconHeight,
                  child: Image.asset(pokemonType.icon, fit: BoxFit.contain),
                ),
                Text(
                  pokemonType.name.toUpperFirst(),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            );
          },
        ),
      );
    }

    // Default horizontal layout
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(pokemonType.icon, height: 30, width: 30),
        const SizedBox(width: 10),
        Text(
          pokemonType.name.toUpperFirst(),
          textAlign: TextAlign.center,
          style: context.theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
