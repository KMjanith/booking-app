import 'dart:async';
import 'package:flutter/material.dart';

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
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("${index}")));
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      //gradient: AppGradients.customGradient,
                      //color: Colors.white,
                      boxShadow: [
                        /* BoxShadow(
                          color: Colors.black, // Shadow color
                          offset: Offset(0, 0), // Offset of the shadow
                          blurRadius: 5, // Blur radius of the shadow
                          spreadRadius: 0, // Spread radius of the shadow
                        ),*/
                      ],
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
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10),
                          child: Row(
                            children: [
                              Text(
                                "From: Fort\nTo : kandy",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Row(
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
