import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../servises/Cancel_api.dart';
import '../procedure/Home.dart';
import '../widgets/AppBarCustom.dart';
import '../widgets/bottomNavigator.dart';
import '../widgets/clipPath.dart';
import '../widgets/drawer.dart';
import '../widgets/input_fields/normal_input.dart';
import 'CancelBooking.dart';

// ignore: must_be_immutable
class CancelCheak extends StatelessWidget {
  CancelCheak({super.key});
  final TextEditingController ReferenceNo = TextEditingController();

  CancelBookingApi cancelBookingApi = CancelBookingApi();

  @override
  Widget build(BuildContext context) {
    http.Client client = http.Client();
    return Scaffold(
      bottomNavigationBar: Bottom_NavigationBar(),
      body: Stack(
        children: [
          const clipPath(),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 30,
          ),
          Positioned(
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      const Center(
                        child: Text("Check Your Booking",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 92, 7, 47))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      const Text(
                          "Enter your reference no to cancel your booking.if you have enough dates you will be refunded.you can refer the refund policies from policies page.section in sidebar.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0))),

                      const Icon(Icons.money_off,
                          size: 150, color: Color.fromARGB(255, 85, 0, 42)),

                      const SizedBox(
                        height: 20,
                      ),

                      //email
                      NormalInput(
                        key: Key("check ticket"),
                          keyboardType: TextInputType.text,
                          icon: const Icon(Icons.numbers),
                          controller: ReferenceNo,
                          labelText: "Reference no",
                          obscureText: false),
                      const SizedBox(
                        height: 10,
                      ),

                      //check refund button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 0, 70, 199),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                              child: const Text("Check",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  barrierDismissible:
                                      false, // Prevent the user from dismissing the dialog
                                  builder: (BuildContext context) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  },
                                );

                                //1 second delay for fetching data
                                await Future.delayed(
                                    const Duration(seconds: 1));

                                final Map<String, dynamic> result =
                                    // ignore: use_build_context_synchronously
                                    await cancelBookingApi.cancelBooking(
                                        context, ReferenceNo.text, client);
                                // ignore: use_build_context_synchronously
                                if (result['statusCode'] == 200) {
                                  // Dismiss the loading indicator
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();

                                  Map<String, dynamic> resultMap = json.decode(
                                      result[
                                          'body']); //convert result strin g in to a Map
                                  print(resultMap);

                                  Get.to(CancelBooking(resultMap: resultMap));

                                  // return errormessage;
                                  // ignore: use_build_context_synchronously
                                } else {
                                  // Dismiss the loading indicator
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();

                                  //map to access the ticket details in another classes
                                  Map<String, dynamic> errormessage =
                                      json.decode(result[
                                          'body']); //convert result string in to a Map

                                  // ignore: use_build_context_synchronously
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.error,
                                    title: 'Oops..',
                                    text: errormessage["error"],
                                  );
                                  //throw Exception('Failed to search cancel'); // Update the error message
                                }
                              }),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      //refund Stats if there is a ticket
                    ],
                  ))),
          CustomAppBar(page: [HomePage()], name: ["Home"]),
        ],
      ),
      drawer: const CustomDrawer(), //side panel
    );
  }
}
