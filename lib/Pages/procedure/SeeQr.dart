import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:screenshot/screenshot.dart';

import '../../servises/Cancel_api.dart';
import '../widgets/AppBarCustom.dart';
import '../widgets/bottomNavigator.dart';
import '../widgets/clipPath.dart';
import '../widgets/drawer.dart';
import '../widgets/input_fields/normal_input.dart';
import 'Home.dart';

class SeeQr extends StatefulWidget {
  const SeeQr({super.key});

  @override
  State<SeeQr> createState() => _SeeQrState();
  //static String Qrdata = '';
}

class _SeeQrState extends State<SeeQr> {
  final TextEditingController ReferenceNo = TextEditingController();
  CancelBookingApi cancelBookingApi = CancelBookingApi();
  dynamic display = Text("qrCode");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Bottom_NavigationBar(),
      body: Stack(
        children: [
          const clipPath(),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 30,
          ),
          Positioned(
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      const Center(
                        child: Text("Your Booking QrCode",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 92, 7, 47))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      const Text(
                          "Enter your reference number.You can see the Qr code of your booking.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0))),

                      // const Icon(Icons.qr_code,
                      //     size: 150, color: Color.fromARGB(255, 85, 0, 42)),

                      const SizedBox(
                        height: 20,
                      ),

                      //email
                      NormalInput(
                          icon: const Icon(Icons.numbers),
                          controller: ReferenceNo,
                          labelText: "Reference no",
                          obscureText: false),
                      const SizedBox(
                        height: 10,
                      ),

                      //check refund button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 0, 70, 199),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            child: const Text("Check",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () async {
                              _makeQrImage();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(child: display), // display goes here
                    ],
                  ))),
          CustomAppBar(page: [HomePage()], name: ["Home"]),
        ],
      ),
      drawer: const CustomDrawer(), //side panel
    );
  }

  _makeQrImage() async {

    //Create an instance of ScreenshotController
    ScreenshotController screenshotController = ScreenshotController();

    if (ReferenceNo.text == '') {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "Please enter Re. No");
    } else {
      String  Qrdata = await cancelBookingApi.GenerateQr(ReferenceNo.text);  //calling API
      setState(() {
        display = Column(
          children: [
            Screenshot(
                controller: screenshotController,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: QrImageView(
                      data: Qrdata,
                      version: QrVersions.auto,
                      size: 300.0,
                    ),
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 199, 0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  child: const Text("Download Qr",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    screenshotController.capture().then((image) => {
                          //Capture Done
                          setState(() {
                          })
                        });
                    const customDirectoryPath = '/storage/emulated/0/Train';
                    final customDirectory = Directory(customDirectoryPath);

                    // Create the custom directory if it doesn't exist
                    if (!(await customDirectory.exists())) {
                      await customDirectory.create(recursive: true);
                      print(
                          'Custom directory created at: $customDirectoryPath');
                    }

                    String fileName =
                        DateTime.now().microsecondsSinceEpoch.toString();
                    String path = '$customDirectoryPath/$fileName';

                    screenshotController
                        .captureAndSave(
                          path,
                          pixelRatio: 2.0,
                          delay: const Duration(milliseconds: 10),
                        )
                        .then((value) => print('Saved'));

                    // ignore: use_build_context_synchronously
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        text: "you can find the qr code in Train folder which has newly created.",
                        onConfirmBtnTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
        Qrdata = '';
      });
    }
  }
}
