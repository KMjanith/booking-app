import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:mongo_dart/mongo_dart.dart';
import '../../Models/Trainmodel.dart';
import '../widgets/AppBarCustom.dart';
import '../widgets/Seatplan.dart';
import '../widgets/bottomNavigator.dart';
import '../widgets/clipPath.dart';
import '../widgets/drawer.dart';
import 'CustomerDetails.dart';
import 'Home.dart';
import 'take_inputs_page.dart';

class SeatView extends StatelessWidget {
  final TrainModel train_details;
  final String className;
  final int seatCount;
  final List<int> seet_view;
  final int maxSeatCount; //max sheet count that can be selected
  final int Price; //ticket price per seat
  final String date; //booking date to add in ticket

  SeatView(
      {super.key,
      required this.train_details,
      required this.date,
      required this.className,
      required this.seatCount,
      required this.seet_view,
      required this.maxSeatCount,
      required this.Price});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Bottom_NavigationBar(),
      drawer: const CustomDrawer(), //side panel
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      //appBar: AppBar(title: Text('Seat View'),),
      body: Stack(
        children: [
           const clipPath(), //Custom clipPath
          Positioned(
            top: 120,
            right: 30,
            left: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(children: [
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Available",
                    style: TextStyle(color: Colors.white),
                  )
                ]),
                Row(children: [
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 0, 0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text("Booked", style: TextStyle(color: Colors.white))
                ]),
                Row(children: [
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text("selected", style: TextStyle(color: Colors.white))
                ]),
              ],
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          const Positioned(
            top: 170,
            right: 50,
            left: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_upward_outlined,
                  color: Colors.white,
                ),
                Text(
                  "Front side of train",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              ],
            ),
          ),

          //calling seat plan
          Positioned(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 200, right: 20, left: 20, bottom: 20),
                child: SizedBox(
                  height: 500,
                  child: ColoredGridView(
                    maxSeatCount: maxSeatCount,
                    gridData: seet_view,
                    seetCount: seatCount,
                  ),
                ),
              ),
            ),
          ),

          //book seat button
          Positioned(
            bottom: 10,
            right: 90,
            left: 90,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 103, 172),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextButton(
                  onPressed: SetSeats,
                  child: const Text('Book Seat ',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
            ),
          ),
          CustomAppBar(
            page: [FirstPage(), HomePage()],
            name: ["change root", "Home"],
          ),
        ],
      ),
      
    );
  }

  //this method is for to calculate the total price after customer select the seats.
  void SetSeats() {
    print(seet_view);

    var selectedtotalSeats = 0;
    List<String> selectedSeatsNo = []; //store the selected seat numbers

    for (int i = 0; i < seet_view.length; i++) {
      if (seet_view[i] == 2) {
        selectedtotalSeats = selectedtotalSeats + 1;
        selectedSeatsNo.add(i.toString());
      }
    }

    //updatedSeatView = seet_view;

    print(seet_view);
    var totalPrice = Price * selectedtotalSeats; //total ticketPrice

    Get.to(CustomerDetails(
        updatedSeatView: seet_view,
        Seatnumbers: selectedSeatsNo,
        date: date,
        passengerCount:
            (selectedtotalSeats), //maxSeatCount-1 because one seat is already booked
        train_details: train_details,
        price: totalPrice));
  }
}
