import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokexplorer/core/constants/app_const.dart';

class DialogProgressPokeball extends StatelessWidget {
  const DialogProgressPokeball({
    super.key,
    required this.hardBackEnabled,
  });

  final bool hardBackEnabled;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: hardBackEnabled,
      child: SimpleDialog(
        title: Text(
          'appLocale.loadingDialogMessage',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        children: <Widget>[
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
    );
  }
}
