import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../Models/resetPassword.dart';
import '../Pages/Auth/login.dart';
import 'DatabaseHandeling/constant.dart';

class ResetPasword {
  static const String baseUrl = '$baseUrl_1/login/resetpassword';

  Future<void> ResetPassword(
      BuildContext context, ResetPasswordModel passwordModel) async {
    final Map<String, dynamic> requestBody = {
      "newpassword": passwordModel.password,
      "confirmpassword": passwordModel.confirmPassword,
      "email": passwordModel.email
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
        text: 'Succesfully Reset your password.please Log in',
        onConfirmBtnTap: () {
          Get.offAll(LoginPage());
        },
      );
    }
  }
}
