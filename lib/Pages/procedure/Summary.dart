// ignore_for_file: unused_local_variable
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:quickalert/quickalert.dart';
import '../../servises/AuthManager.dart';
import '../Auth/SignUp.dart';
import '../widgets/AppBarCustom.dart';
import '../widgets/TicketFinal.dart';
import '../widgets/clipPath.dart';
import 'Home.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class TicketSummary extends StatelessWidget {
  final FInalTicket finalTicket;

  const TicketSummary({super.key, required this.finalTicket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const clipPath(),
        ListView(
          children: [
            //show full ticket which can be downloaded in to the Train folder in the mobile
            finalTicket,

            //odf download button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 235, 0, 78),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextButton(
                    onPressed: () async {
                      final pdf = pw.Document();

                      pdf.addPage(
                        pw.Page(
                          pageFormat: PdfPageFormat.a4,
                          build: (pw.Context context) {
                            return pw.Center(
                              child: pw.Column(children: [
                                pw.Container(
                                  child: pw.Column(
                                    children: [],
                                  ),
                                ),
                              ]),
                            );
                          },
                        ),
                      );
                      if (await Permission.manageExternalStorage
                          .request()
                          .isGranted) {
                        try {
                          const customDirectoryPath =
                              '/storage/emulated/0/Train';
                          final customDirectory =
                              Directory(customDirectoryPath);

                          // Create the custom directory if it doesn't exist
                          if (!(await customDirectory.exists())) {
                            await customDirectory.create(recursive: true);
                            print(
                                'Custom directory created at: $customDirectoryPath');
                          }

                          const filePath =
                              '/storage/emulated/0/Train/my_custom_pdf.pdf';

                          // Save the PDF to the custom path
                          final file = File(filePath);
                          await file.writeAsBytes(await pdf.save());

                          //print('PDF saved to $filePath');
                          // ignore: use_build_context_synchronously
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              title: "saved",
                              text: 'PDF saved to $filePath. Also see QR by entering reference number in sideBar.',
                              onConfirmBtnTap: (){
                                Get.off(HomePage());
                              }
                              );
                        } catch (e) {
                          //print('Error: $e');
                           // ignore: use_build_context_synchronously
                           QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              title: "saved",
                              text: 'Error: $e');
                        }
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.download_rounded,
                          size: 36,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Download Ticket with QR",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
        if (!AuthManager.isLoggedIn)
          CustomAppBar(
            page: [SignUpPage(), HomePage()],
            name: const ["Sign up", "Home"],
          ),
        if (AuthManager.isLoggedIn)
          CustomAppBar(
            page: [HomePage()],
            name: const ["Home"],
          ),
      ]),
    );
  }
}
