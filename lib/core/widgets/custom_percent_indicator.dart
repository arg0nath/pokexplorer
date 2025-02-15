import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokexplorer/core/utilities/app_utils.dart';
import 'package:pokexplorer/core/variables/app_variables.dart';

class CustomPercentIndicator extends StatelessWidget {
  const CustomPercentIndicator({
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
    final tmpPercent = (value) / 256; //bigest value
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$name :', style: Theme.of(context).textTheme.bodyMedium),
        LinearPercentIndicator(
          width: logicalWidth * 0.6,
          animation: true,
          barRadius: const Radius.circular(20),
          lineHeight: 20.0,
          animationDuration: 1500,
          percent: tmpPercent,
          progressColor: AppUtils.gradientFromType(type).first,
        ),
        Text('$value', style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
