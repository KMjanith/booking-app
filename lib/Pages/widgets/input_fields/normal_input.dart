import 'package:flutter/material.dart';

class NormalInput extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final Icon icon;

  const NormalInput({
    required this.controller,
    required this.labelText,
    required this.obscureText,
    required this.icon,
  });

  @override
  State<NormalInput> createState() => _NormalInputState();
}

class _NormalInputState extends State<NormalInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        height: 60,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10)),
          child: TextField(
            controller: widget.controller,
            obscureText: widget.obscureText,
            decoration: InputDecoration(
                icon: widget.icon,
                labelText: widget.labelText,
                labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 92, 92, 92),
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),
      ),
    );
  }
}
