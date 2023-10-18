import "package:flutter/material.dart";
import 'package:dropdown_search/dropdown_search.dart';
import '../../../Models/stations.dart';

class InputFieldDropDown extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final Icon icon;

  InputFieldDropDown(
      {required this.controller, required this.labelText, required this.icon});

  @override
  State<InputFieldDropDown> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputFieldDropDown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.001),
                borderRadius: BorderRadius.circular(10)),
            child: DropdownSearch<String>(
              popupProps: const PopupProps.menu(
                showSelectedItems: true,
                showSearchBox: true,
              ),
              items: Staions,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                    icon: widget.icon,
                    labelText: widget.labelText,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              onChanged: (value) {
                print(value);
                widget.controller.text = value!;
              },
            ),
          ),
        ],
      ),
    );
  }
}
