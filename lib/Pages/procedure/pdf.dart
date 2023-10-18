import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../widgets/TicketFinal.dart';
import '../widgets/drawer.dart';
import 'Home.dart';


class PdfMaker extends StatelessWidget {
  final FInalTicket pdfWidget;
  const PdfMaker({required this.pdfWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () async {
              final pdf = pw.Document();

              pdf.addPage(
                pw.Page(
                  pageFormat: PdfPageFormat.a4,
                  build: (pw.Context context) {
                    return pw.Center(
                      child: pw.Container(
                        decoration: pw.BoxDecoration(color: PdfColors.amber),
                      ),
                    );
                  },
                ),
              );
              if (await Permission.manageExternalStorage.request().isGranted) {
                try {
                  const customDirectoryPath = '/storage/emulated/0/Train';
                  final customDirectory = Directory(customDirectoryPath);

                  // Create the custom directory if it doesn't exist
                  if (!(await customDirectory.exists())) {
                    await customDirectory.create(recursive: true);
                    print('Custom directory created at: $customDirectoryPath');
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
                      text:
                          'PDF saved to $filePath. if you want to see the QR code of your booking go to the QR section and enter the ticket reference number. ',
                      onConfirmBtnTap: () {
                        Get.offAll(HomePage());
                      
                      });
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
            child: Text("Generate PDF and Save"),
          )
        ],
      ),
      drawer: const CustomDrawer(), //side panel
    );
  }
}
