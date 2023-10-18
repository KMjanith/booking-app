import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../servises/AuthManager.dart';
import '../widgets/AppBarCustom.dart';
import '../widgets/Colors.dart';
import '../widgets/clipPath.dart';
import '../widgets/Info.dart';
import '../widgets/drawer.dart';
import '../widgets/policyWidgets.dart';
import '../Auth/SignUp.dart';
import '../Auth/login.dart';
import '../widgets/popular.dart';
import 'take_inputs_page.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Create a PageController to manage the PageView
    PageController pageController = PageController();

    // Build the main scaffold
    return Scaffold(
      body: Stack(
        children: [
          
          const clipPath(),  //Custom clipPath
          ListView(children: [
            const Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 90,
                  ),
                  Text(
                    "Book Your\nTrain Today!",   //page topic
                    style: TextStyle(
                      color: Color.fromARGB(255, 92, 7, 47),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //page content
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                        "Book your train ticket in just a few clicks.we wish you a safe and pleasant journey!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 92, 7, 47))),
                  )
                ],
              ),
            ),

            const SizedBox(
              height: 60,
            ),

            //Get Started button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 65,
                  width: 339,
                  decoration: BoxDecoration(
                      gradient: AppGradients.customGradient,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border:
                          Border.all(color: Color.fromARGB(255, 255, 255, 255)),
                      borderRadius: BorderRadius.circular(20)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        //Get.to(FirstPage());
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>FirstPage()));
                      },
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Get Started',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 3, 3, 3)),
                          ),
                          Spacer(),
                          // Icon(
                          //   Icons.arrow_forward_sharp,
                          //   size: 35,
                          //   color: Colors.black,
                          // )
                          Image.asset("Assets/giphy.gif"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),

            //popular widgets
            SizedBox(
              height: 380,
              width: double.infinity,

              // Use the PopularTile widget with automatic scrolling

              child: Column(children: [
                const Center(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Popular",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        
                      ],
                    ),
                  ),
                )),

                //Animated tile
                PopularTile(pagecontroller: pageController),
              ]),
            ),

            //Our Service widget
            const Info(content: "these are our Service", title: "Services"),

            const SizedBox(
              height: 10,
            ),

            //Our Policies
            const Info(content: "these are our Policies ", title: "Policies"),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PolicyWidget(color: Colors.blue, context: context, icon: Icons.book_online, title: "Bookings",content: "this will state the booking details"),
                  PolicyWidget(color: Colors.red, context: context, icon:  Icons.cancel, title: "Cancel and\nRefund",content: "this will indicate the Cancellation process"),
                  
                 
                ],
              ),
            ),

            //About Us

            const Info(content: "Contact us Always ", title: "About"),

            const SizedBox(
              height: 10,
            )
          ]),
          if (!AuthManager.isLoggedIn)
            CustomAppBar(
              page: [LoginPage(), SignUpPage()],
              name: const ["Login", "Sign up"],
            ),
          if (AuthManager.isLoggedIn)
            CustomAppBar(
              page: [],
              name: const [],
            ),
        ],
      ),
      drawer: const CustomDrawer(), //side panel
    );
  }
}
