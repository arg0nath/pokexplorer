import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';

class LogoPlaceholder extends StatelessWidget {
  const LogoPlaceholder({
    super.key,
    required this.primaryLogoImagePath,
    this.secondaryLogoImagePath,
  });

  final String primaryLogoImagePath;
  final String? secondaryLogoImagePath;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: context.width,
        // color: const Color.fromARGB(108, 76, 105, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(primaryLogoImagePath).animate(delay: 200.ms).fade(duration: 100.ms, curve: Curves.easeOutQuad),
            if (secondaryLogoImagePath != null)
              Flexible(
                  child: Image.asset(
                secondaryLogoImagePath!,
                width: context.width * 0.5,
              )).animate(delay: 300.ms).fade(duration: 1700.ms, curve: Curves.easeOutQuad),
          ],
        ));
  }
}
