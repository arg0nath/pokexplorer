import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/utils/type/get_type_color_by_name.dart';

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
        Text('$name :', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
        LinearPercentIndicator(
          width: context.width * 0.6,
          animation: true,
          barRadius: AppConst.scrollbarRadius,
          lineHeight: 20.0,
          animationDuration: 1500,
          percent: tmpPercent,
          progressColor: Color(getColorForType(type)),
        ),
        Text('$value', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
