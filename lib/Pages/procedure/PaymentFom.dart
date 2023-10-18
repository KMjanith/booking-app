import 'package:flutter/material.dart';
//import 'package:testbookigapp/servises/DatabaseHandeling/mongodb.dart';

//import 'package:testbookigapp/Pages/widgets/AvailabilityTile.dart';

import '../../Models/Ticket.dart';
import '../../Models/Trainmodel.dart';
import '../../servises/Bookings_api.dart';
import '../widgets/input_fields/normal_input.dart';

class PaymentForm extends StatefulWidget {
  final TrainModel train_details;
  final int totalPrice;
  final TicketDetails ticket;
  final List<int> finalSeatView;
  PaymentForm(
      {super.key,
      required this.totalPrice,
      required this.train_details,
      required this.finalSeatView,
      required this.ticket});

  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  int selectedPaymentMethod = -1; // -1 indicates no selection

  final TextEditingController cardNo = TextEditingController();
  final TextEditingController expDate = TextEditingController();
  final TextEditingController CVC = TextEditingController();
  final Booking_api bookticket = Booking_api();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              const Text("payment Details", //train name
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Select a payment method",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedPaymentMethod = 0;
                          });
                          // Perform other operations
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedPaymentMethod == 0
                                      ? Colors.blue // Change color as needed
                                      : Colors.transparent,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Image(
                              image: AssetImage("Assets/download (1).png"),
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedPaymentMethod = 1;
                          });
                          // Perform other operations
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedPaymentMethod == 1
                                      ? Colors.blue // Change color as needed
                                      : Colors.transparent,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Image(
                              image:
                                  AssetImage("Assets/MasterCard_Logo.svg.png"),
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Enter Card Details",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  NormalInput(
                      icon: const Icon(Icons.numbers),
                      controller: cardNo,
                      labelText: "card no",
                      obscureText: false), //card number
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        //expire date
                        child: NormalInput(
                            icon: const Icon(Icons.data_exploration_rounded),
                            controller: expDate,
                            labelText: 'MM/YY',
                            obscureText: false),
                      ),
                      Expanded(
                        //CVC
                        child: NormalInput(
                            icon: const Icon(Icons.comment_bank_rounded),
                            controller: CVC,
                            labelText: 'CSC',
                            obscureText: false),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                //price
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  height: 53,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Price:",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text("LKR${widget.totalPrice.toString()}.00",
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ]),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  //pay button
                  width: 130,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    child: const Text("Pay",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      print(widget.ticket.firstName);

                      //save to daatabase
                      await bookticket.addBooking(context, widget.ticket);

                      print(widget.finalSeatView);

                      // for (int i = 0; i < widget.finalSeatView.length; i++) {
                      //   if (widget.finalSeatView[i] == 2) {
                      //     widget.finalSeatView[i] = 1;
                      //   }
                      // }

                      // print("final seat view");
                      // print(widget.finalSeatView);
                      // mongoDatabase.updateTrainSheetView(
                      //     AvailabilityTile.TrainID!,
                      //     widget.finalSeatView,
                      //     AvailabilityTile.ClassType!);
                    },
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Container(
                  //cancel button
                  width: 130,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 235, 0, 78),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    child: const Text("Cancel",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
