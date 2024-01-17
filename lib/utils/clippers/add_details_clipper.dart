import 'package:flutter/material.dart';

/// Oval bottom clipper to clip widget in oval shape at the bottom side
class OvalBottomBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, 0)
      ..lineTo(0, size.height - 40)
      ..quadraticBezierTo(
        size.width / 4,
        size.height,
        size.width / 2,
        size.height,
      )
      ..quadraticBezierTo(
        size.width - size.width / 4,
        size.height,
        size.width,
        size.height - 40,
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
