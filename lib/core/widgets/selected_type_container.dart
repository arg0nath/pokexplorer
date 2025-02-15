import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pokexplorer/core/utilities/app_utils.dart';
import 'package:pokexplorer/core/variables/app_constants.dart';
import 'package:pokexplorer/core/variables/app_variables.dart';

class SelectedTypeContainer extends StatefulWidget {
  const SelectedTypeContainer({super.key, required this.typeName});

  final String typeName;

  @override
  State<SelectedTypeContainer> createState() => _SelectedTypeContainerState();
}

class _SelectedTypeContainerState extends State<SelectedTypeContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // margin: const EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30, width: 30, child: Image.asset(AppUtils.typeToAssetIcon(widget.typeName))),
          const SizedBox(width: 10),
          Text(widget.typeName.toUpperFirst(), textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class PokeballBackground extends StatelessWidget {
  const PokeballBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 20 * math.pi / 180,
      child: Opacity(
        opacity: 0.05,
        child: Image.asset(
          width: logicalWidth * 0.6,
          POKEBALL_OUTLINED_PNG,
        ),
      ),
    );
  }
}
