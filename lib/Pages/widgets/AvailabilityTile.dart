import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../Models/Trainmodel.dart';
import '../procedure/SeatPage.dart';

class AvailabilityTile extends StatelessWidget {
  final String Actual_date; //this date is to show the date in Ticket summary
  final TrainModel data;
  final int passengers;
  final String from;
  final String to;
  final Map<String, dynamic> priceList;

  AvailabilityTile(
      {required this.data,
      required this.Actual_date,
      required this.passengers,
      required this.from,
      required this.to,
      required this.priceList});

  static ObjectId? TrainID;
  static int? ClassType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: 360,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 252, 255, 222),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                  offset: Offset(0, 3),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.train,
                        size: 58,
                      ),
                      Column(
                        children: [
                          Text(
                            data.name, //train name
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              textStyle("${data.from} -"),
                              const SizedBox(width: 12),
                              textStyle(data.to),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 75,
                  width: 300,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Color.fromARGB(17, 209, 49, 49)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                textStyle("from: "),
                                textStyle(from),
                              ],
                            ),
                            textStyle(
                                data.arrivalTimes[data.stations.indexOf(from)]),
                          ],
                        ),
                        const Text(
                          "select\nclass",
                          style: TextStyle(
                              color: Color.fromARGB(255, 241, 36, 36),
                              fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                textStyle("to: "),
                                textStyle(to),
                              ],
                            ),
                            textStyle(
                                data.arrivalTimes[data.stations.indexOf(to)]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              //sheet tiles
              Expanded(
                child: ListView.builder(
                  itemCount: data.classTypes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          //sheet buttons
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: const MaterialStatePropertyAll(
                                    Color.fromARGB(255, 1, 74, 134)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(45)),
                                ))),

                            //go to the seatView
                            onPressed: () {
                              _goToSeatView(index);
                            },

                            //class details showing widget
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(
                                          Icons.airline_seat_recline_extra,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        if (data.classTypes[index] ==
                                            "First Class")
                                          classTextStyle("1st class"),
                                        if (data.classTypes[index] ==
                                            "Second Class")
                                          classTextStyle("2nd class"),
                                        if (data.classTypes[index] ==
                                            "Third Class")
                                          classTextStyle("3rd class"),
                                      ],
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade200,
                                            borderRadius: const BorderRadius
                                                .only(
                                                bottomLeft: Radius.circular(5),
                                                bottomRight: Radius.circular(5),
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(30))),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                          child: Text(
                                            "${data.sheetAvailable[index]} sheets available",
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 1, 53, 95),
                                                fontSize: 15),
                                          ),
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      "Price per seat",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "LKR ${priceList["ticketPrices"][index]}.00",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

//common text styling
  Widget textStyle(String data) {
    return Text(
      data,
      style: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 18,
          //fontFamily: 'Roboto',
          fontWeight: FontWeight.bold),
    );
  }

  //classType text
  Widget classTextStyle(String classType) {
    return Text(
      classType,
      style: const TextStyle(color: Colors.white, fontSize: 20),
    );
  }

  _goToSeatView(int index) {
    List<int> listWithZeros = data.sheet_view[
        index]; //duplicate list to make changes of the seat selection
    print(listWithZeros);
    print(priceList["ticketPrices"][index]);
  

    ClassType = index;

    //go to seet view
    Get.to(SeatView(
      date: Actual_date,
      train_details: data,
      Price: priceList["ticketPrices"][index],
      className: data.classTypes[index],
      seatCount: data.sheetAvailable[index],
      seet_view: listWithZeros,
      maxSeatCount: passengers + 1,
    ));
  }
}
