import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../servises/Cancel_api.dart';
import '../procedure/Home.dart';
import '../widgets/AppBarCustom.dart';
import '../widgets/bottomNavigator.dart';
import '../widgets/clipPath.dart';
import '../widgets/drawer.dart';
import '../widgets/input_fields/normal_input.dart';

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
                            
                              await cancelBookingApi.cancelBooking(
                                  context, ReferenceNo.text, client);
                                 // ignore: use_build_context_synchronously
                             
                            },
                          ),
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
