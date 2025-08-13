import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  /* void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(message),backgroundColor: isError ? Theme.of(this).colorScheme.error : Theme.of(this).snackBarTheme.backgroundColor,),);
  } */

  ThemeData get theme => Theme.of(this);

  /// Returns the current [TextTheme] of the context.
  TextTheme get textTheme => theme.textTheme;

  /// Returns the current [ColorScheme] of the context.
  ColorScheme get colorScheme => theme.colorScheme;

  /// Returns the current [Brightness] of the context.
  Brightness get brightness => theme.brightness;

  Size get size => MediaQuery.sizeOf(this);
  double get width => size.width;
  double get height => size.height;
}
