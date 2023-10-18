import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import '../../servises/login_api.dart';
import '../widgets/clipPath.dart';
import '../widgets/drawer.dart';
import '../widgets/input_fields/OTPInBox.dart';
import 'dart:async';

class OTPdialogBox extends StatefulWidget {
  final String OriginalOTP;
  final Widget page;
  final String email;

  final ApiServiceLogin _apiService = ApiServiceLogin();

  OTPdialogBox({
    super.key,
    required this.OriginalOTP,
    required this.email,
    required this.page,
  });

  final OTPInput = TextEditingController();

  @override
  State<OTPdialogBox> createState() => _OTPdialogBoxState();
}

class _OTPdialogBoxState extends State<OTPdialogBox> {
  // ignore: unused_field
  int timeleft = 120; //time limit
  bool timedout = false; //bool for check timed out or not

  @override
  void initState() {
    super.initState();
    _startCountDown();
  }

//timer logic
  void _startCountDown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timeleft > 0) {
          timeleft = timeleft - 1;
        } else {
          timer.cancel();
          timedout = true;
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                //this is for if timed out
                backgroundColor: Colors.white,
                title: const Text("Try Again!!", textAlign: TextAlign.center),
                content: const Text(
                    "OTP verification time out.Press Resend if you want to get another OTP.",
                    textAlign: TextAlign.center),
                actions: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text("Back")),
                        TextButton(
                            onPressed: () async {
                              await widget._apiService
                                  .Sendotp(context, widget.email, widget.page);

                              //resetting the timer again to 120

                              timeleft = 120;
                              timedout = false;
                              _startCountDown();
                            },
                            child: const Text("Resend"))
                      ],
                    ),
                  )
                  //back button
                ],
              );
            },
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            const clipPath(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Email verification",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "A verification OTP number has sent to your email ${widget.email} please type that here to verify you before timed out.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(child: OTPinBox(digit: widget.OTPInput)),
                  const SizedBox(
                    height: 15,
                  ),

                  //timer display
                  Text(
                    "time: ${timeleft.toString()}",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 150,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 207, 211, 255),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),

                            //verify button
                            child: TextButton(
                              onPressed: () {
                                if ((widget.OriginalOTP ==
                                        widget.OTPInput.text) &&
                                    (timedout == false)) {
                                  //print(verified);

                                  //user verified
                                  ApiServiceLogin.verified = true;

                                  //print(verified);
                                  /*QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.success,
                                    title: "Success",
                                    text: "Email verified successfully",
                                    animType: QuickAlertAnimType.rotate,
                                    onConfirmBtnTap: () {
                                      Navigator.pop(context);
                                      Get.off(widget.page);
                                    },
                                  );*/
                                  Navigator.pop(context);
                                  Get.off(widget.page);
                                } else {
                                  QuickAlert.show(
                                      title: "MisMatch!!",
                                      context: context,
                                      type: QuickAlertType.error,
                                      confirmBtnText: "Re send",
                                      onConfirmBtnTap: () async {
                                        await widget._apiService.Sendotp(
                                            context, widget.email, widget.page);
                                        // ignore: use_build_context_synchronously
                                      },
                                      text:
                                          "timed out or entered code mismatch\nenter correct code or Tap resend");
                                }
                              },
                              child: const Text('Verify ',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 68, 68, 68),
                                      fontSize: 20)),
                            ),
                          ),
                          Container(
                            width: 150,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 207, 211, 255),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),

                            //verify button
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel ',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 68, 68, 68),
                                      fontSize: 20)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        drawer: const CustomDrawer(), //side panel
        );
  }
}
