import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';

class CustomAppbarBackgroundWaveClipper extends CustomClipper<Path> {
// sweet maths
  @override
  Path getClip(Size size) {
    Path path = Path();
    const double minSize = AppConst.typeDetailsAppBarDelegateMinExtend;
    final int p1Diff = ((minSize - size.height) * 0.3).truncate().abs();
    path.lineTo(0.0, size.height - p1Diff);

    final Offset controlPoint = Offset(size.width * 0.6, size.height);
    final Offset endPoint = Offset(size.width, minSize);

    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomAppbarBackgroundWaveClipper oldClipper) => oldClipper != this;
}
