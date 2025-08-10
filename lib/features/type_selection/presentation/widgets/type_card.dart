import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/extensions/string_ext.dart';
import 'package:pokexplorer/core/common/models/entities/pokemon_type.dart';

class TypeCard extends StatelessWidget {
  const TypeCard({
    super.key,
    required this.type,
    required this.selectedTypeName,
    required this.onTap,
  });

  final PokemonType type;
  final String selectedTypeName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = type.name == selectedTypeName;

    return InkWell(
      onTap: onTap,
      child: Stack(
        children: <Widget>[
          Card(
            color: type.color,
            child: Center(child: Text(type.name.toUpperFirst())),
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: Icon(
              isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
