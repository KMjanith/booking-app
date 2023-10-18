import 'package:flutter/material.dart';

class PolicyWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final BuildContext context;
  final String content;

  const PolicyWidget(
      {super.key,
      required this.color,
      required this.context,
      required this.icon,
      required this.title,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color.fromARGB(255, 255, 255, 255)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(content),
                  )
                ],
              ),
            );
          },
        );
      },
      child: Container(
        height: 150,
        width: 100,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              blurRadius: 12,
              color: Color.fromARGB(255, 216, 203, 203),
              blurStyle: BlurStyle.normal,
              offset: Offset(2, 2),
              spreadRadius: 5
            )
          ],
           color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 75,
                color: color,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
