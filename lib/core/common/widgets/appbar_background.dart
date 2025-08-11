import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/widgets/appbar_wave_clipper.dart';

class AppbarGradientBackground extends StatelessWidget {
  const AppbarGradientBackground({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomAppbarBackgroundWaveClipper(),
      child: Container(
        width: context.width,
        height: AppConst.pokemonDetailsAppBarDelegateMaxExtend,
        decoration: BoxDecoration(
          color: color,
        ),
      ),
    );
  }
}
