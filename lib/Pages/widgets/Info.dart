import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  final String title;
  final String content;
  const Info({super.key,required this.content,required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Color.fromARGB(255, 92, 7, 47),
              fontSize: 29,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
         
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
                content,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 92, 7, 47))),
          )
        ],
      ),
    );
  }
}
