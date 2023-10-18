import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../servises/AuthManager.dart';
import '../Auth/SignUp.dart';
import '../Auth/login.dart';
import '../widgets/AppBarCustom.dart';
import '../widgets/clipPath.dart';
import '../widgets/drawer.dart';
import '../widgets/input_fields/DateInput.dart';
import '../widgets/input_fields/drop_dwn.dart';
import '../widgets/input_fields/normal_input.dart';
import 'show_availability_page.dart';

// ignore: must_be_immutable
class FirstPage extends StatelessWidget {
  final TextEditingController _fromControler = TextEditingController();
  final TextEditingController _toControler = TextEditingController();
  final TextEditingController _DateController = TextEditingController();
  final TextEditingController _PasegerCount = TextEditingController();
  DateTime? _selectedDate;

  FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          /*Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 213, 230, 245)),
          ),*/
          const clipPath(),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Pick Your Way",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 92, 7, 47))),
                    ),
                  ),

                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                          "Select your origin, destination, date and number of passengers. All field must be fill to check available trains",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0))),
                    ),
                  ),

                  //Image.asset(
                  //"Assets/book-a-train-ticket-online-6276502-5217098.webp"),

                  const SizedBox(
                    height: 20,
                  ),
                  //From input
                  InputFieldDropDown(
                    icon: const Icon(Icons.arrow_forward),
                    controller: _fromControler,
                    labelText: "From",
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  //To input
                  InputFieldDropDown(
                    icon: const Icon(Icons.arrow_back),
                    controller: _toControler,
                    labelText: "To",
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  //date input
                  DateInput(
                      birthDateController: _DateController,
                      selectedDate: _selectedDate),

                  const SizedBox(
                    height: 10,
                  ),

                  //passenger count input
                  NormalInput(
                      icon: const Icon(Icons.person),
                      controller: _PasegerCount,
                      labelText: "pasengers",
                      obscureText: false),

                  const SizedBox(
                    height: 28,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Container(
                      //search train button
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 70, 199),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        child: const Text("Available Trains",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          if (_fromControler.text.isEmpty ||
                              _toControler.text.isEmpty ||
                              _DateController.text.isEmpty ||
                              _PasegerCount.text.isEmpty) {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: 'Oops...',
                              text: 'Sorry,some fields are empty',
                            );
                            return;
                          }
                          //print(_DateController.text);
                          

                          Get.to(TrainDisplay(
                            Actual_date: _DateController.text,
                            passengerCount: int.parse(_PasegerCount.text),
                            from: _fromControler.text,
                            to: _toControler.text,
                            Date: DateTake(_DateController.text),
                          ));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!AuthManager.isLoggedIn)
            CustomAppBar(
              page: [LoginPage(), SignUpPage()],
              name: const ["Login", "Sign up"],
            ),
          if (AuthManager.isLoggedIn)
            CustomAppBar(
              page: [],
              name: const [],
            ),
        ],
      ),
       drawer: const CustomDrawer(), //side panel
    );
  }

  //function for take the Daily, Weekends, Weekdays according to the given input
  List<String> DateTake(String date) {
    print(date);
    final dayNames = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    final List<String> dateList = [];

    final inputDate = DateTime.parse(date);
    int index = (inputDate.weekday) - 1;
    final dayName = dayNames[index];
    print(dayName);

    if (dayName == "Sunday" || dayName == "Saturday") {
      dateList.add('Daily');
      dateList.add("Weekends");
    } else {
      dateList.add('Daily');
      dateList.add('Weekdays');
    }

    print(dateList);
    return dateList;
  }
}
