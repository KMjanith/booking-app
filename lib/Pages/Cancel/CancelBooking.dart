import 'package:flutter/material.dart';
import '../../servises/login_api.dart';
import '../widgets/AppBarCustom.dart';
import '../widgets/clipPath.dart';
import '../widgets/drawer.dart';
import '../widgets/ticketAttri.dart';
import '../procedure/Home.dart';
import 'CancelConfirm.dart';

// ignore: must_be_immutable
class CancelBooking extends StatelessWidget {
  final Map<String, dynamic> resultMap;
  CancelBooking({super.key, required this.resultMap});

  final ApiServiceLogin _apiService =
      ApiServiceLogin(); //Api instance to call sendOtp function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  padding: EdgeInsets.all(15.0),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      const Center(
                        child: Text("Confirm Cancellation",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 92, 7, 47))),
                      ),
                      const Text(
                          "following details are regarding to your booking. please read our cancellation policies. once you click the cancel button a verification code will send your email which is in the booking details. after verify your mail your refund amount will be transfered to your account.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0))),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(children: [
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("Ticket Details",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 44, 5, 23))),
                            ),
                          ),

                          //making the ticket view
                          TicketAttribute(
                              attribute: "ReferenceNo: ",
                              value: resultMap["booking"]["ReferenceNo"]),
                          TicketAttribute(
                              attribute: "Train Name",
                              value: resultMap["booking"]["trainName"]),
                          TicketAttribute(
                              attribute: "Origin",
                              value: resultMap["booking"]["from"]),
                          TicketAttribute(
                              attribute: "Destination",
                              value: resultMap["booking"]["to"]),
                          TicketAttribute(
                              attribute: "Time from -> to",
                              value:
                                  '${resultMap["booking"]["timeFrom"]} -> ${resultMap["booking"]["timeTo"]}'),
                          TicketAttribute(
                              attribute: "Date",
                              value: resultMap["booking"]["date"]),
                          TicketAttribute(
                              attribute: "FirstName",
                              value: resultMap["booking"]["firstName"]),
                          TicketAttribute(
                              attribute: "LastName",
                              value: resultMap["booking"]["lastName"]),
                          TicketAttribute(
                              attribute: "mobile",
                              value: resultMap["booking"]["mobile"]),
                          TicketAttribute(
                              attribute: "email",
                              value: resultMap["booking"]["email"]),
                          TicketAttribute(
                              attribute: "Passenger count",
                              value: resultMap["booking"]["passengerCount"]
                                  .toString()),
                          TicketAttribute(
                              attribute: "Class Type",
                              value: resultMap["booking"]["class"]),
                          TicketAttribute(
                              attribute: "Seat Numbers",
                              value: resultMap["booking"]["seat_numbers"]
                                  .join(', ')),
                          TicketAttribute(
                              attribute: "Price",
                              value: "LKR.${resultMap["booking"]["price"]}"),
                        ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(children: [
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("Refund status",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 92, 7, 47))),
                            ),
                          ),
                          TicketAttribute(
                              attribute: "Remaining days: ",
                              value: resultMap["daysRemaining"].toString()),
                          TicketAttribute(
                              attribute: "Refund amount",
                              value: resultMap["refund"].toString()),

                          //check refund button
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 252, 66, 66),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                child: const Text("Cancel booking",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () async {
                                  _sendOTP(context);

                                },
                              ),
                            ),
                          ),
                        ]),
                      )
                    ],
                  ))),
          CustomAppBar(page: [HomePage()], name: ["Home"]),
        ],
      ),
      drawer: const CustomDrawer(), //side panel
    );
  }

  _sendOTP(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    await _apiService.Sendotp(context, resultMap["booking"]["email"],
        CancelCOnfirm(resultMap: resultMap)); //sending the otp to the mail
  }
}
