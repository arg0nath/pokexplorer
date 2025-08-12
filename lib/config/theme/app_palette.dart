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

  static const Color black = Color(0xff313132);
  static const Color grey = Color(0xFF979797);
  static const Color shadowLight = Color(0xFFB4B4B4);
  static const Color shadowDark = Color(0xFF404040);

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
