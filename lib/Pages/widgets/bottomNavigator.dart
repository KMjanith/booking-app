import 'package:booking_app/Pages/Auth/SignUp.dart';
import 'package:booking_app/Pages/Auth/login.dart';
import 'package:booking_app/Pages/procedure/SeeQr.dart';
import 'package:booking_app/Pages/procedure/take_inputs_page.dart';
import 'package:booking_app/servises/AuthManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../procedure/Home.dart';
import '../procedure/userProfile.dart';

class Bottom_NavigationBar extends StatelessWidget {
  const Bottom_NavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0, top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Home navigator
            InkWell(
                onTap: () {
                  Get.offAll(HomePage());
                },
                child: Icon(Icons.home)),

            //Search train navigator
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoModalPopupRoute(
                          builder: (context) => FirstPage()));
                },
                child: Icon(Icons.search)),

            //SeeQr
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      CupertinoModalPopupRoute(builder: (context) => SeeQr()));
                },
                child: Icon(Icons.qr_code_2_rounded)),

            //UserProfile checker
            if (AuthManager.isLoggedIn)
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoModalPopupRoute(
                            builder: (context) => MyProfile()));
                  },
                  child: Icon(Icons.person_2_rounded)),

            if (!AuthManager.isLoggedIn)
              //Login navigator
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoModalPopupRoute(
                            builder: (context) => LoginPage()));
                  },
                  child: Icon(Icons.login)),

            if (!AuthManager.isLoggedIn)
              //signUp navigator
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoModalPopupRoute(
                            builder: (context) => SignUpPage()));
                  },
                  child: Icon(Icons.app_registration)),
          ],
        ),
      ),
    );
  }
}
