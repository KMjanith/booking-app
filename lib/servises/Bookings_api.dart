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
import 'DatabaseHandeling/constant.dart';

class Booking_api {
  static const String baseUrl = 'http://$baseUrl_1:4000/booking';

  Future<void> addBooking(BuildContext context, TicketDetails ticket) async {
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
      // ignore: use_build_context_synchronously
      throw Exception(QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops..',
          text: response.body)); // Update the error message
    } else {
      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Great',
        text:
            'Your booking was successful.click ok to view your ticket and download the QR code',
        onConfirmBtnTap: () {
          Navigator.pop(context);
          //Go to Qr display page
          Get.off(TicketSummary(
              finalTicket:
                  FInalTicket(RefNumber: response.body, ticket: ticket)));
        },
      );
    }
  }
}
