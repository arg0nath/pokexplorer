import 'package:flutter/material.dart';
import 'package:pokexplorer/core/variables/app_constants.dart';

class CustomAppbarBackButton extends StatelessWidget {
  const CustomAppbarBackButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: onPressed,
      icon: const Icon(Icons.arrow_back_outlined, color: PRIMARY_TEXT_COLOR),
    );
  }
}
