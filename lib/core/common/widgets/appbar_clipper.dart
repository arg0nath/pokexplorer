import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/constants/app_constants.dart';

class CustomAppbarBackgroundWaveClipper extends CustomClipper<Path> {
// sweet maths
  @override
  Path getClip(Size size) {
    var path = Path();
    const minSize = TYPE_DETAILS_APP_BAR_DELEGATE_MIN_EXTEND;
    final p1Diff = ((minSize - size.height) * 0.3).truncate().abs();
    path.lineTo(0.0, size.height - p1Diff);

    final controlPoint = Offset(size.width * 0.6, size.height);
    final endPoint = Offset(size.width, minSize);

    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomAppbarBackgroundWaveClipper oldClipper) => oldClipper != this;
}
