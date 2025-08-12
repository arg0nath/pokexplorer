import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/utils/type/get_type_color_by_name.dart';

/// A widget that displays a Pokémon's stat as a percentage bar.
class StatPercentBar extends StatelessWidget {
  const StatPercentBar({
    super.key,
    required this.value,
    required this.name,
    required this.type,
  });
  final String type;
  final String name;
  final int value;

  @override
  Widget build(BuildContext context) {
    final double tmpPercent = (value) / 256; //bigest value
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('$name :', style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
        LinearPercentIndicator(
          barRadius: AppConst.scrollbarRadius,
          width: context.width * 0.6,
          animationDuration: 1500,
          percent: tmpPercent,
          lineHeight: 20.0,
          animation: true,
          backgroundColor: context.colorScheme.onSurface.withAlpha(20),
          progressColor: Color(getColorForType(type)),
        ),
        Text('$value', style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
