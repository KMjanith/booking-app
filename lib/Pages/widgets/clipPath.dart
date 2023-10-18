import 'package:flutter/material.dart';

import 'Colors.dart';
import 'CustomClipart..dart';

class clipPath extends StatelessWidget {
  const clipPath({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomClipperLeft(),
      child: Container(
        height: 400,
        decoration: const BoxDecoration(
          gradient: AppGradients.customGradient, //Lineargardient
        ),
      ),
    );
  }
}
