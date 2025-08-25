import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pokexplorer/config/theme/app_palette.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/extensions/string_ext.dart';
import 'package:pokexplorer/core/common/models/entities/pokemon_type.dart';

class GenericTypeCard extends StatefulWidget {
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
  State<GenericTypeCard> createState() => _GenericTypeCardState();
}

class _GenericTypeCardState extends State<GenericTypeCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      reverseCurve: Curves.fastOutSlowIn.flipped,
      curve: Curves.fastOutSlowIn,
    );
    if (widget.isSelected) _controller.forward();
  }

  @override
  void didUpdateWidget(covariant GenericTypeCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Trigger animation when becoming selected
    if (!oldWidget.isSelected && widget.isSelected) {
      _controller.forward(from: 0.0);
    } else if (oldWidget.isSelected && !widget.isSelected) {
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int typeColor = widget.pokemonType.colorValue;
    return InkWell(
      borderRadius: AppConst.mainRadius,
      onTap: widget.onTap,
      child: CustomPaint(
        painter: BorderAnimationPainter(
          animation: _animation,
          color: Color(typeColor),
          borderRadius: 28, //
        ),
        child: Container(
          decoration: BoxDecoration(
            color: !widget.isSelected ? Color(typeColor).withAlpha(50) : Color(typeColor).withAlpha(190),
            borderRadius: AppConst.mainRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.pokemonType.name.toUpperFirst(),
                    style: !widget.isSelected
                        ? context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)
                        : context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900, color: AppPalette.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Image.asset(widget.pokemonType.icon, height: 100, fit: BoxFit.scaleDown),
                    (widget.isSelected)
                        ? Icon(
                            Icons.radio_button_checked_rounded,
                            size: 25,
                            color: context.theme.iconTheme.color?.withAlpha(120),
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
      ),
    ).animate().fade(duration: 300.ms, curve: Curves.easeOutQuad).scale();
  }
}

class BorderAnimationPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;
  final double borderRadius;

  BorderAnimationPainter({
    required this.animation,
    required this.color,
    required this.borderRadius,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final Path fullPath = Path();

    final double w = size.width;
    final double h = size.height;
    final double r = borderRadius;

// Start at top-right corner
    fullPath.moveTo(w - r, 0);
// Top edge
    fullPath.arcToPoint(Offset(w, r), radius: Radius.circular(r));
    fullPath.lineTo(w, h - r);
// Right-bottom corner
    fullPath.arcToPoint(Offset(w - r, h), radius: Radius.circular(r));
    fullPath.lineTo(r, h);
// Bottom-left corner
    fullPath.arcToPoint(Offset(0, h - r), radius: Radius.circular(r));
    fullPath.lineTo(0, r);
// Top-left corner
    fullPath.arcToPoint(Offset(r, 0), radius: Radius.circular(r));
    fullPath.lineTo(w - r, 0); // back to start to close

    // Extract the animated portion of the path
    final PathMetrics metrics = fullPath.computeMetrics();
    final Path path = Path();

    for (final PathMetric metric in metrics) {
      final double extractLength = metric.length * animation.value;
      path.addPath(metric.extractPath(0, extractLength), Offset.zero);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant BorderAnimationPainter oldDelegate) => oldDelegate.animation != animation || oldDelegate.color != color;
}
