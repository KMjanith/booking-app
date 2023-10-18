import 'package:booking_app/Pages/Auth/SignUp.dart';
import 'package:booking_app/Pages/Auth/login.dart';
import 'package:booking_app/Pages/procedure/take_inputs_page.dart';
import 'package:flutter/material.dart';

import '../procedure/Home.dart';

class Bottom_NavigationBar extends StatelessWidget {
  const Bottom_NavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Home navigator
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => 
                    HomePage()
                  ));
                },
                child: Icon(Icons.home)),

                //Search train navigator
                InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FirstPage()));
                },
                child: Icon(Icons.search)),

                //Login navigator
                InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Icon(Icons.login)),

                //signUp navigator
                InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: Icon(Icons.app_registration)),
            
          ],
        ),
      );
  }
}