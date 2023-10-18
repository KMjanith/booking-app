import 'package:flutter/material.dart';

class TicketAttribute extends StatelessWidget {
  final String attribute;
  final String? value;
  const TicketAttribute({super.key,required this.attribute,required this.value});

  @override
  Widget build(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.all(8.0),
     child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$attribute :",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            width: 10,
          ),
   
         
          Container(
            height: 40,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                value!,
                style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
   );
  }
}



  
