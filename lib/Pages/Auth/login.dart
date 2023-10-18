import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../servises/login_api.dart';
import '../procedure/Home.dart';
import '../widgets/AppBarCustom.dart';
import '../widgets/clipPath.dart';
import '../widgets/drawer.dart';
import '../widgets/input_fields/normal_input.dart';
import 'ResetPassword.dart';
import 'SignUp.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final ApiServiceLogin _apiService =
      ApiServiceLogin(); // instance of ApiService
  // ignore: unused_field

  @override
  Widget build(BuildContext context) {

    http.Client client = http.Client();
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          /*Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 213, 230, 245)),
          ),*/
          const clipPath(),
          const SizedBox(
            height: 30,
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 110,
                  ),
                  const Center(
                    child: Text("Log in",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 92, 7, 47))),
                  ),

                  Image.asset("Assets/login.png"),

                  const SizedBox(
                    height: 10,
                  ),

                  //email
                  NormalInput(
                    icon: const Icon(Icons.email_rounded),
                      controller: email,
                      labelText: "email",
                      obscureText: false),
                  const SizedBox(
                    height: 10,
                  ),
                  //password
                  NormalInput(
                    icon: const Icon(Icons.password_rounded),
                      controller: password,
                      labelText: "password",
                      obscureText: true),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          showForgotPasswordDialog(context);

                        },
                        child: const Text(
                          "forgot password?",
                          style: TextStyle(fontSize: 20),
                        )),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Container(
                      //search train button
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 70, 199),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        child: const Text("Log in",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          await _apiService.login(
                              context, email.text, password.text, client);
                          // Add the new item using your ApiService
                        },
                      ),
                    ),
                  ),
                  //Already have an account widget
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account",
                          style: TextStyle(fontSize: 18)),
                      TextButton(
                        onPressed: () {
                          Get.off(SignUpPage());
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(color: Colors.blue, fontSize: 18),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          CustomAppBar(
            page: [HomePage(), SignUpPage()],
            name: const ["Home", "Sign up"],
          ),
        ],
      ),
      drawer: const CustomDrawer(), //side panel
    );
  }

  void _disposed() {
    email.text = '';
    password.text = '';
    _emailController.text = '';
  }

//function to show the dialog box to enter the email when forget password button is clicked
 void showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: const Text("Forgot Password?"),
          content: TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: "Enter your email",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                //print("pressed");
                //print(_emailController.text);
                showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(child: CircularProgressIndicator());
                    });

                await _apiService.Sendotp(context,
                    _emailController.text,
                    PasswordReset(email: _emailController
                            .text)); //sending the otp to the mail
                _disposed(); //clear email textfield

              },
              child: Text("Submit"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
