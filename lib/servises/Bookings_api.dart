import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../Models/Ticket.dart';
import '../Pages/procedure/Summary.dart';
import '../Pages/widgets/TicketFinal.dart';
import 'constant.dart';

class Booking_api {
  static const String baseUrl = '$baseUrl_1/booking';

  Future<void> addBooking(BuildContext context, TicketDetails ticket) async {

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent the user from dismissing the dialog
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );


    final Map<String, dynamic> requestBody = {
      //"ReferenceNo": '', // "ReferenceNo": "1234567890
      "firstName": ticket.firstName,
      "lastName": ticket.lastName,
      "mobile": ticket.mobileNo,
      "email": ticket.email,
      "NIC": ticket.NIC,
      "passengerCount": ticket.PassengerCount,
      "trainName": ticket.trainName,
      //"trainNo": ticket.trainNo,
      "from": ticket.Orign,
      "to": ticket.Destination,
      "date": ticket.Date,
      "price": ticket.Price,
      "seat_numbers": ticket.SeatNumbers,
      "class": ticket.classType,
      "timeFrom": ticket.timeFromTO[0],
      "timeTo": ticket.timeFromTO[1],
      //"Status": "Pending",
    };
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody), // Encode the map as JSON
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode != 200) {

      // Dismiss the loading indicator
      // ignore: use_build_context_synchronously
      Navigator.of(context, rootNavigator: true).pop();

      // ignore: use_build_context_synchronously
      throw Exception(QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops..',
          text: response.body)); // Update the error message
    } else {
      // Dismiss the loading indicator
      // ignore: use_build_context_synchronously
      Navigator.of(context, rootNavigator: true).pop();


      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Great',
        text:
            'Your booking was successful.click ok to view your ticket and download the QR code',
        onConfirmBtnTap: () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          //Go to Qr display page
          //before going to the summary page system go to the final ticket page to make the ticket summary widget.
          // in there the screenshot of the QR code will take and save in to the local storage
          Get.off(TicketSummary(
              finalTicket:
                  FInalTicket(RefNumber: response.body, ticket: ticket)));
        },
      );
    }
  }
}
