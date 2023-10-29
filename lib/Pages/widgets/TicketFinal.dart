import 'dart:io';

import 'package:flutter/material.dart ';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import '../../Models/Ticket.dart';
import 'ticketAttri.dart';

// ignore: must_be_immutable
class FInalTicket extends StatelessWidget {
  final TicketDetails ticket;
  final String RefNumber;
  FInalTicket({super.key, required this.RefNumber, required this.ticket});
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    //Create an instance of ScreenshotController
    _scree();
    return Column(
      children: [
        const SizedBox(
          height: 90,
        ),
        const Center(
            child: Text(
          "Your Ticket",
          style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 92, 7, 47)),
        )),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Text("Ref: " + RefNumber,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 10),

                      //this ticket object is generated by customerDetails page.
                      TicketAttribute(
                          attribute: "Train No", value: ticket.trainNo),
                      TicketAttribute(
                          attribute: "Train Name", value: ticket.trainName),
                      TicketAttribute(attribute: "Origin", value: ticket.Orign),
                      TicketAttribute(
                          attribute: "Destination", value: ticket.Destination),
                      TicketAttribute(
                          attribute: "Time from -> to",
                          value:
                              "${ticket.timeFromTO[0]} -> ${ticket.timeFromTO[1]}"),
                      TicketAttribute(attribute: "Date", value: ticket.Date),
                      TicketAttribute(
                          attribute: "FirstName", value: ticket.firstName),
                      TicketAttribute(
                          attribute: "LastName", value: ticket.lastName),
                      TicketAttribute(
                          attribute: "mobile", value: ticket.mobileNo),
                      TicketAttribute(
                          attribute: "Passenger count",
                          value: ticket.PassengerCount.toString()),
                      TicketAttribute(
                          attribute: "Class Type", value: ticket.classType),
                      TicketAttribute(
                          attribute: "Seat Numbers",
                          value: ticket.SeatNumbers.join(', ')),
                      TicketAttribute(
                          attribute: "Price",
                          value: "LKR." + ticket.Price.toString()),

                          //taking a screenshot of the Qr code and save it into the local storage
                      Screenshot(
                        controller: screenshotController,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: QrImageView(
                            data: ticket.ticketDetailsToString(ticket),
                            version: QrVersions.auto,
                            size: 170.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _scree() async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      const customDirectoryPath = '/storage/emulated/0/Download/Train';
      final customDirectory = Directory(customDirectoryPath);

      // Create the custom directory if it doesn't exist
      if (!(await customDirectory.exists())) {
        await customDirectory.create(recursive: true);
        print('Custom directory created at: $customDirectoryPath');
      }
      //String fileName = DateTime.now().microsecondsSinceEpoch.toString();
      // Split the RefNumber using "/"
      List<String> parts = RefNumber.split('/');

      // Remove the first portion (TBS) and join the remaining parts back
      String newRefNumber = parts.sublist(1).join('/');

      String path = '$customDirectoryPath/$newRefNumber';

      screenshotController
          .captureAndSave(
            path,
            pixelRatio: 2.0,
            delay: const Duration(milliseconds: 10),
          )
          .then((value) => print('Saved'));
    }
  }
}
