import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: Column(
          children: [
            Text(
              'appLocale.loadingDialogMessage',
              style: context.theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Lottie.asset(
              LOADING_POKEBALL_LOTTIE,
              height: 120,
              width: 120,
              repeat: true,
              reverse: true,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
