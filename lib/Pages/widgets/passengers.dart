import 'package:flutter/material.dart';

import 'input_fields/normal_input.dart';

class PassengerForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController nicController;
  final int passengerIndex;

  PassengerForm({
    required this.nameController,
    required this.nicController,
    required this.passengerIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Passenger $passengerIndex',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          NormalInput(
            keyboardType: TextInputType.text,
            icon: const Icon(Icons.person_3_rounded),
              controller: nameController,
              labelText: "Name",
              obscureText: false),
          const SizedBox(
            height: 10,
          ),
          NormalInput(
            keyboardType: TextInputType.text,
            icon: const Icon(Icons.perm_identity_rounded),
              controller: nicController, labelText: "NIC", obscureText: false)
        ],
      ),
    );
  }
}
