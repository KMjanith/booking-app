import 'package:flutter/material.dart';

class AppGradients {
  static const LinearGradient customGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0.1, 0.4, 0.6, 0.9],
    colors: [
      Color.fromARGB(255, 255, 27, 179),
      Color.fromARGB(255, 247, 179, 89),
      Color.fromARGB(255, 134, 149, 236),
      Color.fromARGB(255, 24, 241, 220),
    ],
  );
}
