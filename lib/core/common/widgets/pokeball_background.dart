import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/res/app_assets.dart';

class PokeballBackground extends StatelessWidget {
  const PokeballBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 0.05,
        child: Transform.rotate(
          angle: 20 * math.pi / 180,
          child: Image.asset(
            width: context.width * 0.6,
            AppAssets.pokeballOutlined,
          ),
        ));
  }
}
