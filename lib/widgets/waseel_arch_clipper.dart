import 'package:flutter/material.dart';

/// يقص اللوحة الداكنة في شاشة الترحيب بمنحنى تكعيبي ناعم من الأعلى
class WaseelArchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.02);
    path.cubicTo(
      size.width * 0.28, -size.height * 0.02,
      size.width * 0.55, size.height * 0.19,
      size.width, size.height * 0.13,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
