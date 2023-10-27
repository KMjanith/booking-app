// ignore: file_names
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DateInput extends StatefulWidget {
  DateTime? selectedDate;
  final TextEditingController birthDateController;
  final Key keys;
  DateInput({super.key, required this.selectedDate, required this.birthDateController,required this.keys});

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900), //range from 1900
      lastDate: DateTime(2100), //range to 2100
    );

    if (picked != null && picked != widget.selectedDate) {
      setState(() {
        widget.selectedDate = picked;
        widget.birthDateController.text =
            widget.selectedDate.toString().split(' ').first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10)),
        child: TextField(
          key: widget.keys,
          controller: widget.birthDateController,
          decoration: InputDecoration(
            icon: Icon(Icons.date_range),
            labelText: "date",
            labelStyle: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w400),
            // suffixIcon: const Icon(
            //   Icons.calendar_today,
            //   color: Color.fromARGB(255, 65, 2, 2),
            // ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 255, 255, 255), width: 2.0),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          readOnly:
              true, // Set the TextField as read-only to prevent manual input
          onTap: () => _selectDate(
              context), // Show the date picker when the TextField is tapped
        ),
      ),
    );
  }
}
