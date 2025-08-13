import 'dart:io';

import 'package:flutter/material.dart';

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
      icon: Platform.isIOS ? const Icon(Icons.arrow_back_ios_new_rounded) : const Icon(Icons.arrow_back_rounded),
    );
  }
}
