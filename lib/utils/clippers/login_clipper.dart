import 'package:flutter/material.dart';

/// Clip widget in wave shape
class WaveClipperTwo extends CustomClipper<Path> {
  WaveClipperTwo({this.reverse = false, this.flip = false});

  /// reverse the wave direction in vertical axis
  bool reverse;

  /// flip the wave direction horizontal axis
  bool flip;

  @override
  Path getClip(Size size) {
    final path = Path();
    if (!reverse && !flip) {
      path.lineTo(0, size.height - 20);

      final firstControlPoint = Offset(size.width / 4, size.height);
      final firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
      path.quadraticBezierTo(
        firstControlPoint.dx,
        firstControlPoint.dy,
        firstEndPoint.dx,
        firstEndPoint.dy,
      );

      final secondControlPoint =
          Offset(size.width - (size.width / 3.25), size.height - 65);
      final secondEndPoint = Offset(size.width, size.height - 40);
      path
        ..quadraticBezierTo(
          secondControlPoint.dx,
          secondControlPoint.dy,
          secondEndPoint.dx,
          secondEndPoint.dy,
        )
        ..lineTo(size.width, size.height - 40)
        ..lineTo(size.width, 0)
        ..close();
    } else if (!reverse && flip) {
      path.lineTo(0, size.height - 40);
      final firstControlPoint = Offset(size.width / 3.25, size.height - 65);
      final firstEndPoint = Offset(size.width / 1.75, size.height - 20);
      path.quadraticBezierTo(
        firstControlPoint.dx,
        firstControlPoint.dy,
        firstEndPoint.dx,
        firstEndPoint.dy,
      );

      final secondCP = Offset(size.width / 1.25, size.height);
      final secondEP = Offset(size.width, size.height - 30);
      path
        ..quadraticBezierTo(
          secondCP.dx,
          secondCP.dy,
          secondEP.dx,
          secondEP.dy,
        )
        ..lineTo(size.width, size.height - 20)
        ..lineTo(size.width, 0)
        ..close();
    } else if (reverse && flip) {
      path.lineTo(0, 20);
      final firstControlPoint = Offset(size.width / 3.25, 65);
      final firstEndPoint = Offset(size.width / 1.75, 40);
      path.quadraticBezierTo(
        firstControlPoint.dx,
        firstControlPoint.dy,
        firstEndPoint.dx,
        firstEndPoint.dy,
      );

      final secondCP = Offset(size.width / 1.25, 0);
      final secondEP = Offset(size.width, 30);
      path
        ..quadraticBezierTo(
          secondCP.dx,
          secondCP.dy,
          secondEP.dx,
          secondEP.dy,
        )
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..close();
    } else {
      path.lineTo(0, 20);

      final firstControlPoint = Offset(size.width / 4, 0);
      final firstEndPoint = Offset(size.width / 2.25, 30);
      path.quadraticBezierTo(
        firstControlPoint.dx,
        firstControlPoint.dy,
        firstEndPoint.dx,
        firstEndPoint.dy,
      );

      final secondControlPoint = Offset(size.width - (size.width / 3.25), 65);
      final secondEndPoint = Offset(size.width, 40);
      path
        ..quadraticBezierTo(
          secondControlPoint.dx,
          secondControlPoint.dy,
          secondEndPoint.dx,
          secondEndPoint.dy,
        )
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..close();
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
