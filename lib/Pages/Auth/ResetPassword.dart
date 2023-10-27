import 'package:flutter/material.dart';
import '../../Models/resetPassword.dart';
import '../../servises/Pass_Reset_Api.dart';
import '../procedure/Home.dart';
import '../widgets/AppBarCustom.dart';
import '../widgets/bottomNavigator.dart';
import '../widgets/clipPath.dart';
import '../widgets/drawer.dart';
import '../widgets/input_fields/normal_input.dart';


class PasswordReset extends StatelessWidget {
  final String email;
  PasswordReset({required this.email});

  final TextEditingController password_1 = TextEditingController();
  final TextEditingController password_confirm = TextEditingController();
  final ResetPasword _passwordResetService = ResetPasword();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Bottom_NavigationBar(),
      body: Stack(
        children: [
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
                    child: Text("Reset Password",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 92, 7, 47))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //email
                  NormalInput(
                    key: Key("passwordInput1"),
                    keyboardType: TextInputType.text,
                      controller: password_1,
                      labelText: "Enter Password",
                      obscureText: false,
                      icon: const Icon(Icons.password)),
                  const SizedBox(
                    height: 10,
                  ),
                  //password
                  NormalInput(
                    key: Key("passwordInput2"),
                    keyboardType: TextInputType.text,
                      controller: password_confirm,
                      labelText: "Confirm password",
                      obscureText: true,
                      icon: const Icon(Icons.password),),

                  const SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Container(
                      //search train button
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 158, 0, 111),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        child: const Text("Reset Password",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          ResetPasswordModel passswordModel =
                              ResetPasswordModel(
                                  email: email,
                                  password: password_1.text,
                                  confirmPassword: password_confirm.text);
                          await _passwordResetService.ResetPassword(
                              context, passswordModel);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomAppBar(
            page: [HomePage(),],
            name: const ["Home"],
          ),
        ],
      ),
      drawer: const CustomDrawer(), //side panel
    );
  }
}
