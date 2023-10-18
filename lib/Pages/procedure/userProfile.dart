import 'dart:convert';

import 'package:flutter/material.dart';
import '../../servises/AuthManager.dart';
import '../../servises/Cancel_api.dart';
import '../../servises/DatabaseHandeling/constant.dart';
import '../Auth/SignUp.dart';
import '../Auth/login.dart';
import '../widgets/AppBarCustom.dart';
import '../widgets/clipPath.dart';
import '../widgets/drawer.dart';
import 'package:http/http.dart' as http;

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  int selectedButtonIndex = 0;
  String firstName = '';
  String LastNAme = '';
  String NIC = '';
  String email = '';
  String mobile = '';
  List<Map<String, dynamic>> bookingDetails = [
    {
      "RefNo": "21212121",
      "date": "2023-15-45",
      "price": 200,
      "from": "A",
      "to": "D",
      "status": "pending"
    },
    {
      "RefNo": "21212121",
      "date": "2023-15-45",
      "price": 200,
      "from": "A",
      "to": "D",
      "status": "pending"
    },
    {
      "RefNo": "21212121",
      "date": "2023-15-45",
      "price": 200,
      "from": "A",
      "to": "D",
      "status": "pending"
    },
    {
      "RefNo": "21212121",
      "date": "2023-15-45",
      "price": 200,
      "from": "A",
      "to": "D",
      "status": "pending"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... (rest of your scaffold code remains unchanged)
      body: FutureBuilder(
        future: _fetchLoginDetails(jsonDecode(AuthManager.token)["userID"]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Return a loading indicator while fetching data
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle errors
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Data has been fetched successfully, update the UI
            Map<String, dynamic>? data = snapshot.data;
            firstName = data?['firstName'];
            LastNAme = data?['lastName'];
            email = data?['email'];
            NIC = data?['NIC'];
            mobile = data?['mobile'];

            return Stack(
              children: [
                const clipPath(),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            profileButton("My profile", 0),
                            profileButton("My bookings", 1)
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        selectedButtonIndex == 0
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Hi $firstName",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      attributeProfiler(
                                          "First Name", firstName),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      attributeProfiler("Last Name", LastNAme),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      attributeProfiler("NIC", NIC),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      attributeProfiler("Email", email),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      attributeProfiler("Mobile", mobile),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              )

                            //this is the My booking widget
                            : Container(
                                height: 600,
                                width: 50,
                                child: ListView.builder(
                                    itemCount: bookingDetails.length,
                                    itemBuilder: (context, index) {
                                      Color color =
                                          Color.fromARGB(255, 255, 117, 117);
                                      print(index);
                                      print(bookingDetails[index]["Status"]);
                                      if (bookingDetails[index]["Status"] ==
                                          "Pending") {
                                        color = Color.fromARGB(255, 0, 255, 8);
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: color,
                                              border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.black12),
                                              )),

                                          //List Tile widget
                                          child: ListTile(
                                            onTap: () async {
                                              CancelBookingApi
                                                  cancelBookingApi =
                                                  CancelBookingApi(); //this object is for navigate to the cancelbooking page
                                              http.Client client = http
                                                  .Client(); //this object is for compelteness of the method
                                              await cancelBookingApi
                                                  .cancelBooking(
                                                      context,
                                                      bookingDetails[index]
                                                          ["ReferenceNo"],
                                                      client);
                                            },
                                            title: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  "Ref.No: ${bookingDetails[index]["ReferenceNo"]}",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    bookingDetails[index]
                                                        ["date"],
                                                    style: TextStyle(
                                                        fontSize: 15)),
                                                Text(
                                                    "Price: LKR ${bookingDetails[index]["price"].toString()}",
                                                    style: TextStyle(
                                                        fontSize: 15)),
                                              ],
                                            ),
                                            trailing: Text(
                                                bookingDetails[index]["Status"],
                                                style: TextStyle(fontSize: 16)),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                      ],
                    ),
                  ),
                ),
                if (!AuthManager.isLoggedIn)
                  CustomAppBar(
                    page: [LoginPage(), SignUpPage()],
                    name: const ["Log in", "Sign up"],
                  ),
                if (AuthManager.isLoggedIn)
                  CustomAppBar(
                    page: [],
                    name: const [],
                  ),
              ],
            );
          }
        },
      ),
      drawer: const CustomDrawer(),
    );
  }

  profileButton(String btnText, int index) {
    Color buttonColor = (selectedButtonIndex == index)
        ? Color.fromARGB(193, 0, 0, 0)
        : Color.fromARGB(33, 0, 0, 0);
    return GestureDetector(
      onTap: () async {
        setState(() {
          // Change the color of the clicked button
          selectedButtonIndex = index;
        });
        if (index == 1) {
          await _fetchBokingDetails(email);
          print(bookingDetails);
        }
      },
      child: Container(
        height: 40,
        width: 160,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            btnText,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  attributeProfiler(String titleNAme, String actualNAme) {
    return Container(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            titleNAme,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black45),
                borderRadius: BorderRadius.circular(12),
                color: Color.fromARGB(143, 255, 255, 255)),
            child: Center(
                child: Text(
              actualNAme,
              style: TextStyle(fontSize: 18),
            )),
          )
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchLoginDetails(String userId) async {
    final Map<String, dynamic> requestBody = {"userID": userId};
    final response = await http.post(
      Uri.parse('http://$baseUrl_1:4000/popupform'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    Map<String, dynamic> temp = jsonDecode(response.body);
    return temp;
  }

  Future<void> _fetchBokingDetails(String email) async {
    final response = await http.get(
      Uri.parse('http://$baseUrl_1:4000/profile/history/${email}'),
      headers: {'Content-Type': 'application/json'},
      //body: jsonEncode(requestBody),
    );
    // print(response.body);
    print(response.body.runtimeType);
    print(response.body);
    // Convert the JSON string to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataList =
        List<Map<String, dynamic>>.from(json.decode(response.body));
    print(dataList.runtimeType);
    bookingDetails = dataList;
  }
}
