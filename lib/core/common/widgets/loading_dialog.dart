import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokexplorer/core/common/res/app_assets.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
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
            AppAssets.loadingPokeballLottie,
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
