// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';

class ThemeColorsReferencePage extends StatelessWidget {
  const ThemeColorsReferencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.theme.colorScheme;

    // List of color names and their corresponding ColorScheme properties
    final List<MapEntry<String, MapEntry<Color, Color>>> colorPairs = <MapEntry<String, MapEntry<Color, Color>>>[
      MapEntry('primary', MapEntry(colorScheme.primary, colorScheme.onPrimary)),
      MapEntry('primaryContainer', MapEntry(colorScheme.primaryContainer, colorScheme.onPrimaryContainer)),
      MapEntry('secondary', MapEntry(colorScheme.secondary, colorScheme.onSecondary)),
      MapEntry('secondaryContainer', MapEntry(colorScheme.secondaryContainer, colorScheme.onSecondaryContainer)),
      MapEntry('tertiary', MapEntry(colorScheme.tertiary, colorScheme.onTertiary)),
      MapEntry('tertiaryContainer', MapEntry(colorScheme.tertiaryContainer, colorScheme.onTertiaryContainer)),
      MapEntry('error', MapEntry(colorScheme.error, colorScheme.onError)),
      MapEntry('errorContainer', MapEntry(colorScheme.errorContainer, colorScheme.onErrorContainer)),
      MapEntry('surface', MapEntry(colorScheme.surface, colorScheme.onSurface)),
      MapEntry('surfaceContainerHigh', MapEntry(colorScheme.surfaceContainerHigh, colorScheme.onSecondaryContainer)),
      MapEntry('outline', MapEntry(colorScheme.outline, Colors.white)),
      MapEntry('shadow', MapEntry(colorScheme.shadow, Colors.white)),
      MapEntry('inverseSurface', MapEntry(colorScheme.inverseSurface, colorScheme.onInverseSurface)),
      MapEntry('inversePrimary', MapEntry(colorScheme.inversePrimary, Colors.white)),
      MapEntry('scrim', MapEntry(colorScheme.scrim, Colors.white)),
    ];

    return ListView.builder(
      itemCount: colorPairs.length,
      itemBuilder: (BuildContext context, int index) {
        final String name = colorPairs[index].key;
        final Color bgColor = colorPairs[index].value.key;
        final Color fgColor = colorPairs[index].value.value;

        return ListTile(
          tileColor: bgColor,
          title: Text(
            name,
            style: TextStyle(
              color: fgColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '#${bgColor.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
            style: TextStyle(color: fgColor),
          ),
        );
      },
    );
  }
}
