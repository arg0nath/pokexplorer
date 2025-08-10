import 'package:flutter/material.dart';

abstract class AppPalette {
  AppPalette._();

  static const Color transparent = Colors.transparent;

  //types
  static const Color fire = Color(0xffef7374);
  static const Color water = Color(0xff74acf5);
  static const Color grass = Color(0xff82c274);
  static const Color electric = Color(0xfffcd659);
  static const Color dragon = Color(0xff8d98ec);
  static const Color psychic = Color(0xfff584a8);
  static const Color ghost = Color(0xffa284a2);
  static const Color dark = Color(0xff998b8c);
  static const Color steel = Color(0xff98c2d1);
  static const Color fairy = Color(0xfff5a2f5);
  static const Color normal = Color(0xffc1c2c1);
  static const Color fighting = Color(0xffffac59);
  static const Color flying = Color(0xffadd2f5);
  static const Color poison = Color(0xffb884dd);
  static const Color ground = Color(0xffb88e6f);
  static const Color rock = Color(0xffcbc7ad);
  static const Color bug = Color(0xffb8c26a);
  static const Color ice = Color(0xff81dff7);

  static const Color white = Color(0xFFE6E6E6);
  static const Color whitish = Color(0xffdbdbdb);
  static const Color black = Color(0xff313132);
  static const Color grey = Color(0xFF979797);
  static const Color shadowLight = Color(0xFFB4B4B4);
  static const Color shadowDark = Color.fromARGB(255, 90, 90, 90);

  //gradients colors
  static const Color _turquoiseGradientFirst = Color(0xFF1CD5C6);
  static const Color _turquoiseGradientSecond = Color(0xff28c9e1);
  static const Color _greenGradientFirst = Color(0xFF74B577);
  static const Color _greenGradientSecond = Color(0xFF66CC6B);
  static const Color _redGradientFirst = Color(0xFFAA4242);
  static const Color _redGradientSecond = Color(0xFFF04F4F);
  //gradients

  static const List<Color> gradientTurquoise = <Color>[_turquoiseGradientFirst, _turquoiseGradientSecond];
  static const List<Color> gradientGrey = <Color>[grey, shadowLight];
  static const List<Color> gradientRed = <Color>[_redGradientFirst, _redGradientSecond];
  static const List<Color> gradientGreen = <Color>[_greenGradientFirst, _greenGradientSecond];
}

class AppColorsScheme {
  // Shared across themes
  static const Color primaryColor = Color(0xffeb7525);
  static const Color primaryLight = Color(0xFFFFA756);
  static const Color primaryDark = Color(0xFFC14F00);

  static const Color onPrimaryColorLight = Color.fromARGB(255, 225, 225, 225);
  static const Color onPrimaryColorDark = Color.fromARGB(255, 34, 34, 34);

//Secondary
  static const Color secondaryColorDark = Color(0xFF212120);
  static const Color secondaryDarkVariant = Color.fromARGB(255, 46, 49, 47);
  static const Color onSecondaryColorDark = Color(0xFF757575);
  static const Color onSecondaryColorDimmedDark = Color(0xFF919191);

  static const Color secondaryColorLight = Color(0xFFE4E4E4);
  static const Color secondaryLightVariant = Color(0xFFDFDDDD);
  static const Color onSecondaryColorLight = Color(0xFFC9C9C9);
  static const Color onSecondaryColorDimmedLight = Color(0xFFA3A3A3);

  //error
  static const Color errorColor = Color(0xFFC92947);
  static const Color onErrorColor = Color(0xFFEDEDED);

//surface
  static const Color surfaceColorLight = Color.fromARGB(255, 235, 235, 235);
  static const Color onSurfaceLight = Color(0xFF212121);

  static const Color mainCardColorDark = Color.fromARGB(199, 88, 88, 88);
  static const Color mainCardColorLight = Color.fromARGB(214, 235, 235, 235);

  static const Color surfaceColorDark = Color(0xFF212120);
  static const Color onSurfaceDark = Color.fromARGB(255, 196, 196, 196);

  static const Color scaffoldDark = Color(0xFF363B38);
  static const Color scaffoldLight = Color(0xFFE2E2E2);
}
