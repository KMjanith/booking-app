import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'dart:convert';
import 'constant.dart';
import '../Pages/procedure/Home.dart';

class CancelBookingApi {
  String baseUrl = '$baseUrl_1/refund';

  Future<Map<String, dynamic>> cancelBooking(
      BuildContext context, String ReferenceNo, http.Client client) async {
    
    final Map<String, dynamic> requestBody = {
      'ReferenceNo': ReferenceNo,
    };
    print(requestBody);
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody), // Encode the map as JSON
    );

    // print(response.statusCode);
    print(response.body);
    final result = {
      "statusCode": response.statusCode,
      "body": response.body,
    };

    print(result);

    return result;
  }

  //update cancelation
  String baseUrlCacelationDone = '$baseUrl_1/refund/cancel-booking';

  Future<void> CacelationDone(BuildContext context, String ReferenceNo,
      String trainName, String classNAme, List<dynamic> seats) async {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent the user from dismissing the dialog
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );
    final Map<String, dynamic> requestBody = {
      'ReferenceNo': ReferenceNo,
      "trainName": trainName,
      "className": classNAme,
      "seats": seats
    };
    print(requestBody);
    final response = await http.post(
      Uri.parse(baseUrlCacelationDone),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody), // Encode the map as JSON
    );

    // print(response.statusCode);
    // print(response.body);

    //error state
    if (response.statusCode != 200) {
      // Dismiss the loading indicator
      // ignore: use_build_context_synchronously
      Navigator.of(context, rootNavigator: true).pop();

      Map<String, dynamic> errormessage =
          json.decode(response.body); //convert result string in to a Map

      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops..',
        text: errormessage["message"],
      ); // Update the error message
    } else {
      // Dismiss the loading indicator
      // ignore: use_build_context_synchronously
      Navigator.of(context, rootNavigator: true).pop();
      //map to access the ticket details in another classes
      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Great',
        text: 'Succesfully Cancelled',
        animType: QuickAlertAnimType.slideInUp,
        onConfirmBtnTap: () {
          Get.offAll(HomePage());
        },
      );
    }
  }

  //end point to get ticket details to generate Qr code
  String baseUrlForGenerateQrCode = '$baseUrl_1/refund/mobile-Qr';

  Future<String> GenerateQr(
    String ReferenceNo,
  ) async {
    final Map<String, dynamic> requestBody = {
      'ReferenceNo': ReferenceNo,
    };

    final response = await http.post(
      Uri.parse(baseUrlForGenerateQrCode),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody), // Encode the map as JSON
    );

    print(response.body);
    //error state
    if (response.statusCode != 200) {
      Map<String, dynamic> errormessage =
          json.decode(response.body); //convert result string in to a Map
      print(errormessage);
      throw Exception("booking not found");
    } else {
      return response.body;
    }
  }
}
