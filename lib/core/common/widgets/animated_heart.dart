import 'package:flutter/material.dart';
import 'package:pokexplorer/config/theme/app_palette.dart';

class AnimatedHeart extends StatelessWidget {
  final bool isActive;
  final Duration _duration = const Duration(milliseconds: 500);
  final Curve _curve = Curves.elasticOut;
  const AnimatedHeart({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isActive ? 0.6 : 0.5,
      duration: _duration,
      curve: _curve,
      child: TweenAnimationBuilder(
        curve: _curve,
        duration: _duration,
        tween: ColorTween(
          begin: AppPalette.grey,
          end: isActive ? Colors.redAccent[200] : AppPalette.grey,
        ),
        builder: (BuildContext context, Color? value, Widget? child) {
          final IconData tmpIcon = isActive ? Icons.favorite_rounded : Icons.favorite_border_rounded;
          return Icon(
            tmpIcon,
            size: 50,
            color: value,
          );
        },
      ),
    );
  }
}
