import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatefulWidget {
  const CustomProgressIndicator({super.key, this.value});

  final double? value;

  @override
  State<CustomProgressIndicator> createState() => _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(value: widget.value, valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFBDBDBD)));
  }
}
