import 'package:flutter/material.dart';

class OTPinBox extends StatelessWidget {
  final TextEditingController digit;
  OTPinBox({super.key, required this.digit});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color.fromARGB(255, 10, 7, 7)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          textAlign: TextAlign.center,
          obscureText: false,
          style: const TextStyle(fontSize: 23,color: Colors.white,fontWeight: FontWeight.bold),
          controller: digit,
        ),
      ),
    );
  }
}
