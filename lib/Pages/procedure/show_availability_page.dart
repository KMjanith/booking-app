import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Models/Trainmodel.dart';
import '../../servises/Search_api.dart';
import '../widgets/AppBarCustom.dart';
import '../widgets/AvailabilityTile.dart';
import '../widgets/bottomNavigator.dart';
import '../widgets/clipPath.dart';
import '../widgets/drawer.dart';
import 'Home.dart';
import 'take_inputs_page.dart';

// ignore: must_be_immutable
class TrainDisplay extends StatelessWidget {
  final int passengerCount;
  final String from;
  final String to;
  final List<String> Date;
  final String Actual_date;

  TrainDisplay(
      {super.key,
      required this.Actual_date,
      required this.Date,
      required this.passengerCount,
      required this.from,
      required this.to});

  @override
  Widget build(BuildContext context) {
    SerachTrain searchTrain = SerachTrain();

    return Scaffold(
      //calling custom bottom Navigation bar
      bottomNavigationBar: Bottom_NavigationBar(),
      body: Stack(children: [
        const clipPath(),
        Positioned(
          top: 100,
          left: 0,
          right: 0,
          bottom: 20,
          child: SizedBox(
            height: 700,
            child: FutureBuilder(
              //calling the searchTrain function from the search_api.dart
              //this is call to the backend
              future: searchTrain.getTrains(
                  from, to, Actual_date, passengerCount, Actual_date),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.data != null && snapshot.data.length != 1) {
                    var totalData = snapshot.data.length -
                        1; //-1 is to omit the last element. because last element i the price list
                    //print(totalData);
                    //print(snapshot.data.runtimeType);
                    //print("Train ID: $trainId");
                    var priceList =
                        snapshot.data.removeLast(); //pricelistobject
                    //print(priceList);
                    //print(snapshot.data);

                    //building the list of Trains which has granted from the back end
                    return ListView.builder(
                      itemCount: totalData,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Text("Available Train ${index + 1}",
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 92, 7, 47))),

                            //calling Available train widget one by one to show the trains
                            AvailabilityTile(
                              Actual_date: Actual_date, //booking date
                              from: from,
                              to: to,
                              passengers: passengerCount,
                              data: TrainModel.fromJson(snapshot.data[index]),
                              priceList: priceList,
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    //Alert dialog to show when there are no trains available
                    return AlertDialog(
                        backgroundColor: Color.fromARGB(255, 0, 5, 68),
                        title: const Text(
                          'OOPS!!',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        content: const Text(
                            'There are no trains available for your choices',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        actions: [
                          ElevatedButton(
                            child: const Text('Try another way'),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ]);
                  }
                }
              },
            ),
          ),
        ),
        //making the AppBar
        CustomAppBar(
          page: [FirstPage(), HomePage()],
          name: const ["change root", "Home"],
        ),
      ]),

      //sidebar
      drawer: const CustomDrawer(),
    );
  }
}
