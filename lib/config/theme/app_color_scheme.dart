import 'package:flutter/material.dart';

final ColorScheme lightColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.redAccent,
  primary: Colors.redAccent,
  brightness: Brightness.light,
  surface: _surfaceColorLight,
  onSurface: _onSurfaceLight,
);

final ColorScheme darkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.redAccent,
  primary: Colors.redAccent,
  brightness: Brightness.dark,
  surface: _surfaceColorDark,
  onSurface: _onSurfaceDark,
);

const Color _surfaceColorLight = Color(0xFFEBEBEB);
const Color _onSurfaceLight = Color(0xFF212121);
const Color _surfaceColorDark = Color(0xFF212120);
const Color _onSurfaceDark = Color(0xFFC4C4C4);
