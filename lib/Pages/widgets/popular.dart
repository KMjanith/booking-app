import 'dart:async';
import 'package:flutter/material.dart';
import '../../servises/constant.dart';

class PopularTile extends StatefulWidget {
  final PageController pagecontroller;

  PopularTile({Key? key, required this.pagecontroller}) : super(key: key);

  @override
  _PopularTileState createState() => _PopularTileState();
}

class _PopularTileState extends State<PopularTile> {
  int pageNumber = 1;
  late Timer curoselTimer;

  @override
  void initState() {
    super.initState();
    // Start the timer for automatic scrolling
    curoselTimer = getTimer();
  }

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 2), (timer) {
      if (pageNumber == 3) {
        pageNumber = 0;
      }
      // Animate to the next page
      widget.pagecontroller.animateToPage(pageNumber,
          duration: const Duration(seconds: 2), curve: Curves.easeInOutCirc);

      setState(() {
        pageNumber++;
      });
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    curoselTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final from_stations = ["Fort", "Fort", "Fort"];
    final to_stations = ["Galle", "Badulla", "Kandy"];

    return Column(
      children: [
        Container(
          height: 300, // Set the desired height for the container
          width: 400,
          // Set the desired width for the container
          child: PageView.builder(
            onPageChanged: (index) {
              pageNumber = index;
            },
            controller: widget.pagecontroller,
            itemBuilder: (_, index) {
              return AnimatedBuilder(
                animation: widget.pagecontroller,
                builder: (ctx, child) {
                  return child!;
                },
                child: GestureDetector(
                  onTap: () {

                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Column(
                              children: [
                                  Text(popular_title[index],style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 10,),
                                  Text(popular_content[index],style: TextStyle(fontSize: 18),)
                              ],
                            ),
                          );
                        });
                  },

                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),

                        //adding image
                        Image.asset(
                          'Assets/${index}.png',
                          scale: 0.945,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10),
                          child: Row(
                            children: [
                              Text(
                                "From: ${from_stations[index]}\nTo : ${to_stations[index]}",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              const Row(
                                children: [
                                  Icon(Icons.star_border_outlined,
                                      color: Colors.amber),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "4.5",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: 3,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Container(
              child: Icon(
                Icons.circle,
                size: 12,
                color: pageNumber == index + 1 ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
