import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pokexplorer/core/common/widgets/loading_dialog.dart';

extension ContextExtension on BuildContext {
  /* void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(message),backgroundColor: isError ? Theme.of(this).colorScheme.error : Theme.of(this).snackBarTheme.backgroundColor,),);
  } */

  ThemeData get theme => Theme.of(this);

  Future<Widget?> showLoadingDialog() {
    return showDialog<Widget>(
      barrierDismissible: false,
      context: this,
      builder: (_) => const LoadingDialog(hardBackEnabled: false).animate().fade(duration: 100.ms).scale(),
    );
  }
}
