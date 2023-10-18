import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../procedure/Home.dart';


class CustomAppBar extends StatefulWidget {
  final List<Widget> page;
  final List<String> name;
  CustomAppBar({required this.page, required this.name});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: 60,
                width: 400,
                decoration: BoxDecoration(
             
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () {
                              Scaffold.of(context)
                                  .openDrawer(); // Open the custom drawer
                            },
                            child: const Icon(
                              Icons.menu, // Change to your icon
                              size: 30,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        );
                      }),
                      Row(
                        children: [
                          for (int i = 0; i < widget.page.length; i++)
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: InkWell(
                                  onTap: () {
                                    if (widget.page[i] == 'Home') {
                                      Get.offAll(HomePage());
                                    }else{
                                        Get.to(widget.page[i]);
                                    }
                                    
                                  },
                                  child: widget.name[i] == 'Home' ? const Icon(
                                    Icons.home,
                                    size: 30,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ):
                                  Text(
                                    widget.name[i],
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
