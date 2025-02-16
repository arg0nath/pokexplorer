import 'package:flutter/material.dart';
import 'package:pokexplorer/core/variables/app_constants.dart';
import 'package:pokexplorer/core/variables/app_variables.dart' as app_vars;
import 'package:pokexplorer/localization/app_localizations.dart';

class NoPokemonIndicator extends StatelessWidget {
  const NoPokemonIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(EMPTY_POKEBALL_PNG, width: app_vars.logicalHeight * 0.1, height: app_vars.logicalHeight * 0.1), // Replace with your image path
        const SizedBox(height: 10),
        Text(LocalizationManager.getInstance().noPokemonFound, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
