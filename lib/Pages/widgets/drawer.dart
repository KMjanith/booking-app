import 'package:booking_app/Pages/procedure/userProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import '../../servises/AuthManager.dart';
import '../Cancel/CancelChek.dart';
import '../procedure/Home.dart';
import '../Auth/SignUp.dart';
import '../Auth/login.dart';
import '../procedure/SeeQr.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFFEDEDED),
        child: Column(
          children: [
            Container(
              height: 150,
              color: Color.fromARGB(255, 255, 193, 7),
              alignment: Alignment.center,
              child: const Text(
                "Hi, User",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (AuthManager.isLoggedIn)
              Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.history),
                    title: Text("Cancel Booking"),
                    onTap: () => Get.to(CancelCheak()),
                  ),
                  ListTile(
                    leading: Icon(Icons.qr_code),
                    title: Text("See QR"),
                    onTap: () => Get.to(SeeQr()),
                  ),
                  ListTile(
                    leading: Icon(Icons.person_2_rounded),
                    title: Text("My profile"),
                    onTap: () => Get.to(MyProfile()),
                  ),
                  ListTile(
                    leading: Icon(Icons.color_lens),
                    title: Text("Log Out"),
                    onTap: () {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.confirm,
                        title: "Are you sure you want to log out?",
                        onConfirmBtnTap: (){
                          AuthManager.logout(); //make the user logged out
                            AuthManager.tokens = ''; //clear the token
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => HomePage()));
                        }
                      );
                      
                    },
                  ),
                ],
              )
            else
              Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.login),
                    title: const Text("Login"),
                    onTap: () => Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => LoginPage())),
                  ),
                  ListTile(
                    leading: const Icon(Icons.app_registration),
                    title: const Text("Sign Up"),
                    onTap: () => Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => SignUpPage())),
                  ),
                  ListTile(
                    leading: const Icon(Icons.history),
                    title: Text("Cancel Booking"),
                    onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => CancelCheak())),
                  ),
                  ListTile(
                    leading: const Icon(Icons.qr_code),
                    title: Text("See QR"),
                    onTap: () => Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => SeeQr())),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
