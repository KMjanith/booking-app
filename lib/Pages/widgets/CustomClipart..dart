import 'dart:ui';

import 'package:flutter/material.dart';

class MyCustomClipperLeft extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double width = size.width;
    double height = size.height;

    path.moveTo(0, 0);
    path.lineTo(0, height);
    //path.quadraticBezierTo(width * 0.5, height - 100, width, height);
    path.lineTo(width, 230);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

/*class MyCustomClipperRight extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double width = size.width;
    double height = size.height;

    path.moveTo(0, 0);
    path.lineTo(0, 230);
    path.lineTo(width, height);
    //path.quadraticBezierTo(width * 0.5, height - 100, width, height);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}*/
