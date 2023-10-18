import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quickalert/quickalert.dart';
import '../../Models/Ticket.dart';
import '../../Models/Trainmodel.dart';
import '../../servises/AuthManager.dart';
import '../../servises/DatabaseHandeling/constant.dart';
import '../widgets/AppBarCustom.dart';
import '../widgets/AvailabilityTile.dart';
import '../widgets/Colors.dart';
import '../widgets/CustomClipart..dart';
import '../widgets/drawer.dart';
import '../widgets/input_fields/normal_input.dart';
import 'Home.dart';
import 'PaymentFom.dart';
import 'package:http/http.dart' as http;

import 'take_inputs_page.dart';

// ignore: must_be_immutable
class CustomerDetails extends StatelessWidget {
  final TrainModel train_details;
  final int price;
  final String date;
  final int passengerCount;
  final List<String> Seatnumbers;
  final List<int> updatedSeatView;

  CustomerDetails(
      {required this.passengerCount,
      required this.updatedSeatView,
      required this.train_details,
      required this.price,
      required this.date,
      required this.Seatnumbers});

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController NIC = TextEditingController();
  TextEditingController mobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //print(jsonDecode(AuthManager.token)["userID"]);
    if (AuthManager.isLoggedIn) {
      loginDetails(jsonDecode(AuthManager.token)["userID"]);
    }

    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: MyCustomClipperLeft(),
            child: Container(
              height: 400,
              decoration: const BoxDecoration(
                gradient: AppGradients.customGradient,
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 0,
            left: 0,
            bottom: 2,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Center(
                      child: Text(
                        "Enter Your Details",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Center(
                      child: Text(
                        "Enter a valid email. we will send you a OTP number to validate your email.that email will use for future communication",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Text(
                    "Total Price: LKR" + price.toString(),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(height: 10),

                  //fsrt name

                  NormalInput(
                      icon: const Icon(Icons.person_2_rounded),
                      controller: firstName,
                      labelText: 'First Name',
                      obscureText: false),

                  const SizedBox(height: 10),

                  //lastname

                  NormalInput(
                      icon: const Icon(Icons.person_2_rounded),
                      controller: lastName,
                      labelText: 'Last Name',
                      obscureText: false),
                  const SizedBox(height: 10),
                  //email

                  NormalInput(
                      icon: const Icon(Icons.email_rounded),
                      controller: email, // Replace with your controller
                      labelText: 'Email',
                      obscureText: false),

                  const SizedBox(height: 10),
                  //NIC

                  NormalInput(
                      icon: const Icon(Icons.perm_identity),
                      controller: NIC, // Replace with your controller
                      labelText: 'NIC',
                      obscureText: false),

                  const SizedBox(height: 10),
                  //Mobile number
                  NormalInput(
                      icon: const Icon(Icons.mobile_friendly_rounded),
                      controller: mobile, // Replace with your controller
                      labelText: 'Mobile',
                      obscureText: false),

                  const SizedBox(
                    height: 20,
                  ),

                  //seat view button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          width: 150,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 0, 103, 172),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextButton(
                            onPressed: () {
                              print(firstName.text);

                              //field fill checking
                              if (firstName.text.isEmpty ||
                                  lastName.text.isEmpty ||
                                  NIC.text.isEmpty ||
                                  email.text.isEmpty ||
                                  mobile.text.isEmpty) {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  title: 'Oops...',
                                  text: 'All field Must be Filled',
                                );
                                return;
                              }

                              //making the full ticket object to generate the QR code.then it will pass to the payment page an then ticket summary page
                              TicketDetails ticket = TicketDetails(
                                classType: train_details
                                    .classTypes[AvailabilityTile.ClassType!]
                                    .toString(),
                                email: email.text,
                                NIC: NIC.text,
                                trainNo: train_details.trainNo.toString(),
                                trainName: train_details.name,
                                Orign: train_details.from,
                                Destination: train_details.to,
                                timeFromTO: [
                                  train_details.arrivalTimes[0].toString() +
                                      "AM",
                                  train_details.departureTimes[0].toString() +
                                      "AM"
                                ],
                                Date: date,
                                firstName: firstName.text,
                                lastName: lastName.text,
                                mobileNo: mobile.text,
                                PassengerCount: passengerCount.toString(),
                                SeatNumbers: Seatnumbers,
                                Price: price.toString(),
                              );

                              _dialogBuilder(context, price, train_details,
                                  ticket, updatedSeatView);
                            },
                            child: const Text('Book Seat',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ),
                        ),
                      ),

                      //Cancel button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          width: 150,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 235, 0, 78),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text('Cancel ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          CustomAppBar(
            page: [FirstPage(), HomePage()],
            name: const ["change root", "Home"],
          ),
        ],
      ),
      drawer: const CustomDrawer(),
    );
  }

  Future<void> loginDetails(String userId) async {
    final Map<String, dynamic> requestBody = {"userID": userId};
    final response = await http.post(
      Uri.parse('http://$baseUrl_1:4000/popupform'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody), // Encode the map as JSON
    );

    //print(jsonDecode(response.body)['firstName']);
    Map<String, dynamic> temp = jsonDecode(response.body);
    firstName.text = temp['firstName'];
    lastName.text = temp['lastName'];
    email.text = temp['email'];
    NIC.text = temp['NIC'];
    mobile.text = temp['mobile'];
  }

  Future<void> _dialogBuilder(
      BuildContext context,
      int totalPrice,
      TrainModel train_details,
      TicketDetails ticket,
      List<int> updatedSeatView) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return PaymentForm(
          finalSeatView: updatedSeatView,
          totalPrice: totalPrice,
          train_details: train_details,
          ticket: ticket,
        );
      },
    );
  }
}
