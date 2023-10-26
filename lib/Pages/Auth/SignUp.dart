import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import '../../Models/item.dart';
import '../../servises/register_api.dart';
import '../procedure/Home.dart';
import '../widgets/AppBarCustom.dart';
import '../widgets/bottomNavigator.dart';
import '../widgets/clipPath.dart';
import '../widgets/drawer.dart';
import '../widgets/input_fields/normal_input.dart';
import 'login.dart';

// ignore: must_be_immutable
class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final ApiService _apiService = ApiService();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController TelephoneNumber = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController NIC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    http.Client client = http.Client();
    return Scaffold(
      bottomNavigationBar: Bottom_NavigationBar(),
      body: Stack(
        children: [
          /*Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 213, 230, 245)),
          ),*/
          const clipPath(),
          Positioned(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(children: [
                  const SizedBox(
                    height: 65,
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text("Sign up",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 92, 7, 47))),
                    ),
                  ),

                  //Image.asset("Assets/register.png"),

                  const Text(
                      "Sign up to book your train ticket in just a few clicks.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16, color: Color.fromARGB(255, 92, 7, 47))),
                  const SizedBox(
                    height: 10,
                  ),
                  //input fields
                  NormalInput(
                    key: Key("firstName"),
                    keyboardType: TextInputType.text,
                    controller: firstName,
                    labelText: "First Name",
                    obscureText: false,
                    icon: const Icon(Icons.person_2_rounded),
                  ), // firstName
                  const SizedBox(
                    height: 10,
                  ),

                  NormalInput(
                    key: Key("lastName"),
                    keyboardType: TextInputType.text,
                    controller: lastName,
                    labelText: "Last Name",
                    obscureText: false,
                    icon: const Icon(Icons.person_2_rounded),
                  ), //passwod input
                  const SizedBox(
                    height: 10,
                  ),
                  NormalInput(
                    key: Key("emalail"),
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    labelText: "Email",
                    obscureText: false,
                    icon: const Icon(Icons.person_2_rounded),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  /*NormalInput(controller: NIC, labelText: "NIC number",
                      obscureText: false),*/
                  NormalInput(
                    key: Key("Tel"),
                      keyboardType: TextInputType.number,
                      icon: Icon(Icons.phone_android),
                      controller: TelephoneNumber,
                      labelText: "Telephone number",
                      obscureText: false),
                  const SizedBox(
                    height: 10,
                  ),
                  NormalInput(
                    key: Key("NIC"),
                      keyboardType: TextInputType.text,
                      icon: Icon(Icons.perm_identity),
                      controller: NIC,
                      labelText: "NIC",
                      obscureText: false),
                  const SizedBox(
                    height: 10,
                  ),
                  NormalInput(
                    key: Key("password"),
                      keyboardType: TextInputType.text,
                      icon: Icon(Icons.password),
                      controller: password,
                      labelText: "Password",
                      obscureText: true),
                  const SizedBox(
                    height: 20,
                  ),
                  //sign up button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Container(
                      //search train button
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 19, 160, 0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        child: const Text("Sign up",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          _signUpMethod(context, client);
                        },
                      ),
                    ),
                  ),

                  //Already have an account widget
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? ",
                          style: TextStyle(fontSize: 18)),
                      TextButton(
                        onPressed: () {
                          Get.off(LoginPage());
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(color: Colors.blue, fontSize: 18),
                        ),
                      )
                    ],
                  )
                ])),
          ),
          CustomAppBar(
            page: [HomePage(), LoginPage()],
            name: const ["Home", "Login"],
          ),
        ],
      ),
      drawer: const CustomDrawer(), //side panel
    );
  }

  void _disposed() {
    firstName.text = '';
    lastName.text = '';
    TelephoneNumber.text = '';
    email.text = '';
    password.text = '';
    NIC.text = '';
  }

  void _signUpMethod(BuildContext context,http.Client client) async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent the user from dismissing the dialog
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    final newItem = Item(
      NIC: NIC.text,
      firstName: firstName.text,
      lastName: lastName.text,
      mobile: TelephoneNumber.text,
      email: email.text,
      password: password.text,
    );

    print(newItem.lastName);

    //1 second delay for fetching data
    await Future.delayed(const Duration(seconds: 1));

    final result = await _apiService.addItem(newItem, client);
    _disposed();

    if (result["statusCode"] != 200) {
      // Dismiss the loading indicator
      // ignore: use_build_context_synchronously
      Navigator.of(context, rootNavigator: true).pop();

      Map<String, dynamic> errormessage =
          json.decode(result["body"]); //convert result string in to a Map

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
