import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../servises/AuthManager.dart';
import '../widgets/AppBarCustom.dart';
import '../widgets/Colors.dart';
import '../widgets/bottomNavigator.dart';
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
      bottomNavigationBar: Bottom_NavigationBar(),
      body: Stack(
        children: [
          const clipPath(), //Custom clipPath
          ListView(children: [
            const Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 90,
                  ),
                  Text(
                    "Book Your\nTrain Today!", //page topic
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
                      key: const Key("getStarted"),
                      onPressed: () {
                        //Get.to(FirstPage());
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => FirstPage()));
                      },
                      child: Row(
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
                          Image.asset("Assets/giphy.gif",width: 36.5,),
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
                Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Popular",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        IconButton(
                            onPressed: mapUrl,
                            icon: Icon(Icons.location_on_outlined))
                      ],
                    ),
                  ),
                )),

                //Animated tile
                PopularTile(pagecontroller: pageController),
              ]),
            ),

            const SizedBox(
              height: 10,
            ),

            //Our Policies
            const Info(content: "", title: "Policies"),
            const SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PolicyWidget(
                    color: Colors.blue,
                    context: context,
                    icon: Icons.book_online,
                    title: "Bookings",
                    content: const Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "How to make a booking",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "1.first hit the" + "Get Started" + "button"),
                              Text(
                                  "2.Then select from and to stations, date you want to go and pasenger count"),
                              Text(
                                  "3.hit the search button(you will see the available trains)"),
                              Text(
                                  "4.select the class type which is showing in blue color.there you will redirect to the seat view page"),
                              Text("5.select the seat you want to book"),
                              Text(
                                  "6.Enter your details and hit the book button"),
                              Text(
                                  "7.Choose a payment method and pay the amount"),
                              Text(
                                  "8.you can see a summary fo your ticket with reference number and QR code, you can download a pdf with all details there."),
                              Text(
                                  "9.pdf is in the /Train Folder in your local storage"),
                              Text(
                                  "10.Download the Qr code by going the seeQr section in the side bar. and download it.")
                            ],
                          ),
                        ),
                      ],
                    )),

                //cancel and refund policy
                PolicyWidget(
                  color: Colors.red,
                  context: context,
                  icon: Icons.cancel,
                  title: "Cancel and\nRefund",
                  content: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Cancel Booking",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "1.Go to the side panel and hit the cancel booking button"),
                            Text("2.then enter your ticket's Ref.no"),
                            Text(
                                "3.then you will see the ticket details, refund amount and remaining days to the journey"),
                            Text(
                                "4.Then you need to verify your email address to ensure that you are the owner of the ticket"),
                            Text(
                                "5.f there is a refund amount, that amount will automatically transfer to your account"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Refund Policy",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text(
                                "Refunded amount will calculate by considering remaining days to the journey and price of the ticket. service charge will not be refunded and refund amount will automatically send to your account"),
                            const SizedBox(
                              height: 15,
                            ),

                            //refund policy table
                            Table(
                              children: const [
                                TableRow(children: [
                                  Text(
                                    "Remaining days",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text("Refund Percentage",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ]),
                                TableRow(children: [
                                  Text("7 or more",
                                      textAlign: TextAlign.center),
                                  Text(
                                    "75%",
                                    textAlign: TextAlign.center,
                                  )
                                ]),
                                TableRow(children: [
                                  Text("2", textAlign: TextAlign.center),
                                  Text(
                                    "50%",
                                    textAlign: TextAlign.center,
                                  )
                                ]),
                                TableRow(children: [
                                  Text("below 2 ", textAlign: TextAlign.center),
                                  Text(
                                    "*no Refund",
                                    textAlign: TextAlign.center,
                                  )
                                ])
                              ],
                              border: TableBorder.all(
                                  borderRadius: BorderRadius.circular(12)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 28,
            ),
            //About Us
            const Info(content: "", title: "About us"),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "Welcome to Stage Pilot Train Ticket Booking System,we are dedicated to providing the best service to our customers.",
                textAlign: TextAlign.center,
              ),
            ),

            //Contact Us
            const Info(content: "", title: "Contact Us"),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "textbooking.20@gmail.com",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    " +1 234 567 8901",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),


            //Go to web site button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: InkWell(
                onTap: () {
                  goWebSite();
                },
                child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(255, 255, 0, 0)),
                    child: const Center(
                      child: Text(
                        "visit our Website",
                        style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
            ),

            //Follow Us
            const Info(content: "", title: "Folllow Us"),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              //For facebook Button
              InkWell(
                onTap: () {
                  goYouTube();
                },
                child: Image.asset(
                  "Assets/download (2).png",
                  height: 28,
                  width: 28,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () {
                  goYouTube();
                },
                child: Image.asset(
                  "Assets/download (3).png",
                  height: 28,
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.facebook,
                    size: 30,
                  )),
            ]),

            const SizedBox(
              height: 10,
            )
          ]),
          if (!AuthManager.isLoggedIn)
            CustomAppBar(
              page: [LoginPage(), SignUpPage()],
              name: const ["Login", "Signup"],
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

 goWebSite() async {
    final Uri uri = Uri.parse("https://stage-pilot.onrender.com/");
    try {
      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $uri');
      }
    } catch (e) {}
  }

  mapUrl() async {
    final Uri uri = Uri.parse("https://www.google.com/maps");
    try {
      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $uri');
      }
    } catch (e) {}
  }

  goYouTube() async {
    final Uri uri = Uri.parse("https://youtu.be/LXLh_lEwdB4");
    try {
      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $uri');
      }
    } catch (e) {}
  }
}
