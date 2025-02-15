import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokexplorer/core/variables/app_constants.dart';
import 'package:pokexplorer/core/variables/app_variables.dart';
import 'package:pokexplorer/localization/app_localizations.dart';

class DialogProgressPokeball extends StatelessWidget {
  const DialogProgressPokeball({
    super.key,
    required this.hardBackEnabled,
  });

  final bool hardBackEnabled;

  @override
  Widget build(BuildContext context) {
    LocalizationManager appLocale = LocalizationManager.getInstance();
    return PopScope(
      canPop: hardBackEnabled,
      child: Center(
        child: Container(
          width: logicalWidth * 0.54,
          height: logicalHeight * 0.3,
          margin: EdgeInsets.symmetric(horizontal: logicalWidth * 0.2, vertical: logicalHeight * 0.1),
          decoration: BoxDecoration(
              border: Border.all(color: DIALOG_BORDER_COLOR, width: DIALOG_BORDER_WIDTH),
              color: WHITE_TOTAL,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(DIALOG_PADDING),
              boxShadow: const <BoxShadow>[BoxShadow(color: Colors.black26, blurRadius: 10.0, offset: Offset(0.0, 10.0))]),
          padding: const EdgeInsets.all(25),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Text(
                    appLocale.loadingDialogMessage,
                    style: Theme.of(context).textTheme.bodySmall,
                  )),
              Expanded(
                  flex: 2,
                  child: Center(
                      child: Lottie.asset(
                    LOADING_POKEBALL_LOTTIE,
                    height: logicalHeight * 0.1,
                    width: logicalHeight * 0.1,
                    repeat: true,
                    reverse: true,
                    fit: BoxFit.contain,
                  ))),
            ],
          )),
        ),
      ),
    );
  }
}
