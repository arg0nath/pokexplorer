import 'package:flutter/material.dart';
import 'package:pokexplorer/core/theme/colors/app_palette.dart';

class CustomProgressIndicator extends StatefulWidget {
  const CustomProgressIndicator({super.key, this.value});

  final double? value;

  @override
  State<CustomProgressIndicator> createState() => _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(value: widget.value, valueColor: const AlwaysStoppedAnimation<Color>(AppPalette.grey));
  }
}
