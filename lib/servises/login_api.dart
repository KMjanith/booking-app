import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'dart:convert';
import '../Pages/Auth/login.dart';
import 'AuthManager.dart';
import 'constant.dart';
import '../Pages/Auth/OTPdialog.dart';

class ApiServiceLogin {
  //late PaswordReset paswordReset;
  late LoginPage createdOTP;
  static const String baseUrl =
      '$baseUrl_1/login';

  Future<int> login(BuildContext context, String email, String password,
      http.Client client) async {
  
      final Map<String, dynamic> requestBody = {
        'email': email,
        'password': password,
      };

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody), // Encode the map as JSON
      );

      print(response.body);
      dynamic token = jsonDecode(response.body);
      print(token["userID"]);

      AuthManager.tokens = response.body; //store the token
      AuthManager.login(); //setting the logged in user true

      return response.statusCode;
      // if (response.statusCode == 200) {
      //   // Dismiss the loading indicator
      //   Navigator.of(context, rootNavigator: true).pop();

      //   // ignore: use_build_context_synchronously
      //   QuickAlert.show(
      //     context: context,
      //     type: QuickAlertType.success,
      //     title: 'Great',
      //     text: 'Successfully logged in',
      //     onConfirmBtnTap: () {
      //       Get.offAll(HomePage());
      //     },
      //   );
      // } else {
      //   // Dismiss the loading indicator
      //   // ignore: use_build_context_synchronously
      //   Navigator.of(context, rootNavigator: true).pop();

      //   // ignore: use_build_context_synchronously
      //   QuickAlert.show(
      //       context: context,
      //       type: QuickAlertType.error,
      //       title: 'Oops..',
      //       text: 'Check username and password again or verify your email');
      // }
    
  }


  //Endpoint to send OTP to the given email
  static const String baseUrlforOTP = '$baseUrl_1/login/sendOTP';
  static bool verified = false;

  Future<void> Sendotp(BuildContext context, String email, Widget Page) async {
    final random = Random();
    final otp = (1000 + random.nextInt(9000)).toString();
    print(otp); // This will print a 4-digit OTP

    final Map<String, dynamic> requestBody = {
      'OTP': otp,
      'recipient_email': email,
    };

    final response = await http.post(
      Uri.parse(baseUrlforOTP),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody), // Encode the map as JSON
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode != 200) {
      //ignore: use_build_context_synchronously
      throw Exception(QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops..',
          text: response.body)); // Update the error message
    } else {
      //object to invoke the verification alertbox
      Get.off(OTPdialogBox(
        // page: PasswordReset(email: email),
        page: Page,
        email: email,
        OriginalOTP: otp,
      ));
    }
  }
}
