import 'package:flutter/material.dart';

import '../../servises/Cancel_api.dart';
import '../widgets/AppBarCustom.dart';
import '../widgets/bottomNavigator.dart';
import '../widgets/clipPath.dart';
import '../procedure/Home.dart';
import '../widgets/drawer.dart';

// ignore: must_be_immutable
class CancelCOnfirm extends StatelessWidget {
  final Map<String, dynamic> resultMap;
  CancelCOnfirm({super.key, required this.resultMap});

  CancelBookingApi cancelBookingApi =
      CancelBookingApi(); //instance to call backend

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Bottom_NavigationBar(),
      body: Stack(
        children: [
          const clipPath(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "cancel Confirmation",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "whe you confirm the cancelation you your Qr code will not be validated any more.yur seat will release and if you have some refund it will automatically refund to your bank account.",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
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
                                color: Color.fromARGB(255, 112, 0, 19),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),

                            //CancelConfirm button
                            child: TextButton(
                              onPressed: () async {
                                print(resultMap["booking"]["ReferenceNo"]);
                                await cancelBookingApi.CacelationDone(context,
                                    resultMap["booking"]["ReferenceNo"],
                                    resultMap["booking"]["trainName"],
                                    resultMap["booking"]["class"],
                                    resultMap["booking"]["seat_numbers"]);
                              },
                              child: const Text('Confirm ',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
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
          ),
          CustomAppBar(page: [HomePage()], name: ["Home"]),
        ],
      ),
      drawer: const CustomDrawer(), //side panel
    );
  }
}
