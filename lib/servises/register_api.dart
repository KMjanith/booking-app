import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'dart:convert';
import '../Models/item.dart';
import '../Pages/Auth/login.dart';
import 'DatabaseHandeling/constant.dart';

class ApiService {
  static const String baseUrl = '$baseUrl_1/register';

  Future<void> addItem(BuildContext context, Item item) async {

 
       // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible:
            false, // Prevent the user from dismissing the dialog
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        },
      );
      final response = await http.post(
        Uri.parse('$baseUrl'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(item.toJson()),
      );
   
      if (response.statusCode != 200) {
        // Dismiss the loading indicator
        // ignore: use_build_context_synchronously
        Navigator.of(context, rootNavigator: true).pop();

        Map<String, dynamic> errormessage =
            json.decode(response.body); //convert result string in to a Map
        // ignore: use_build_context_synchronously
        throw Exception(QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Oops..',
            text: errormessage["error"]));
      } else {
         // Dismiss the loading indicator
        // ignore: use_build_context_synchronously
        Navigator.of(context, rootNavigator: true).pop();
        print('Item added');
        // ignore: use_build_context_synchronously
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Registered',
          text:
              "verification email has sent to your email.please verify the email and log in",
          onConfirmBtnTap: () {
            Get.off(LoginPage());
          },
        );
      }
   
    

    
  }
}
