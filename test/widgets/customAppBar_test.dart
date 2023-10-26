import 'package:booking_app/Models/Trainmodel.dart';
import 'package:booking_app/Pages/procedure/Home.dart';
import 'package:booking_app/Pages/procedure/SeatPage.dart';
import 'package:booking_app/Pages/procedure/show_availability_page.dart';
import 'package:booking_app/Pages/procedure/take_inputs_page.dart';
import 'package:booking_app/servises/AuthManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group("Logged in state", () {
    setUp(() => {AuthManager.login()});
    //homepage
    testWidgets(
        'CustomAppBar shows empty tabs when user is logged in in homepage',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: HomePage(),
      ));

      // Verify that HomePage is rendered
      expect(find.text('Book Your\nTrain Today!'), findsOneWidget);

      // Verify that CustomAppBar with empty tabs is rendered
      expect(find.text('Log in'), findsNothing);
      expect(find.text('Sign up'), findsNothing);
    });

    //take input page
    testWidgets(
        'CustomAppBar shows empty tabs when user is logged in in take_inputs_page',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: FirstPage(),
      ));
      // Verify that HomePage is rendered
      expect(find.text('Pick Your Way'), findsOneWidget);

      // Verify that CustomAppBar with empty tabs is rendered
      expect(find.text('Log in'), findsNothing);
      expect(find.text('Sign up'), findsNothing);
    });



    TrainModel data = TrainModel(
        name: "Train 1",
        from: "M",
        to: "K",
        trainNo: 555,
        routes: [1, 2],
        dates: 'Daily',
        stations: ["L", "M", "K", "E", "A", "L", "M", "K"],
        arrivalTimes: [
          "14.55",
          "15.35",
          "16.55",
          "17.15",
          "18.45",
          "19.55",
          "20.45",
          "21.45"
        ],
        departureTimes: [
          "1.25",
          "2.05",
          "3.25",
          "3.45",
          "5.15",
          "6.35",
          "7.35",
          "8.35"
        ],
        classTypes: ["First Class"],
        sheetAvailable: [18],
        sheet_view: []);

    //SeatView page
    testWidgets(
        'CustomAppBar shows empty tabs when user is logged in in train SeatView Page',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: SeatView(
          Price: 900,
          className: 'First class',
          date: '2023-09-17',
          maxSeatCount: 3,
          seatCount: 2,
          seet_view: [1, 2],
          train_details: data,
        ),
      ));

      // Verify that HomePage is rendered
      expect(find.text('Front side of train'), findsOneWidget);

      // Verify that CustomAppBar with empty tabs is rendered
      expect(find.text('change root'), findsOneWidget);
    });
  });

  group("Logged out state", () {
    setUp(() => {AuthManager.logout()});
    //homepage
    testWidgets(
        'CustomAppBar shows empty tabs when user is logged in in homepage',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: HomePage(),
      ));

      // Verify that HomePage is rendered
      expect(find.text('Book Your\nTrain Today!'), findsOneWidget);

      // Verify that CustomAppBar with empty tabs is rendered
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Signup'), findsOneWidget);
    });

    //take input page
    testWidgets(
        'CustomAppBar shows empty tabs when user is logged in in take_inputs_page',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: FirstPage(),
      ));
      // Verify that HomePage is rendered
      expect(find.text('Pick Your Way'), findsOneWidget);

      // Verify that CustomAppBar with empty tabs is rendered
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Signup'), findsOneWidget);
    });

    //train availability page
    testWidgets(
        'CustomAppBar shows empty tabs when user is logged in in train availability page',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: TrainDisplay(
          Actual_date: '2023-09-17',
          Date: ['Daily', "Weekdays"],
          passengerCount: 2,
          from: 'C',
          to: 'D',
        ),
      ));

      // Verify that HomePage is rendered
      //expect(find.text('Available Trains'), findsOneWidget);

      // Verify that CustomAppBar with empty tabs is rendered
      expect(find.text('change root'), findsOneWidget);
      //expect(find.text('Home'), findsOneWidget);
    });

    TrainModel data = TrainModel(
        name: "Train 1",
        from: "M",
        to: "K",
        trainNo: 555,
        routes: [1, 2],
        dates: 'Daily',
        stations: ["L", "M", "K", "E", "A", "L", "M", "K"],
        arrivalTimes: [
          "14.55",
          "15.35",
          "16.55",
          "17.15",
          "18.45",
          "19.55",
          "20.45",
          "21.45"
        ],
        departureTimes: [
          "1.25",
          "2.05",
          "3.25",
          "3.45",
          "5.15",
          "6.35",
          "7.35",
          "8.35"
        ],
        classTypes: ["First Class"],
        sheetAvailable: [18],
        sheet_view: []);

    //SeatView page
    testWidgets(
        'CustomAppBar shows empty tabs when user is logged in in train SeatView Page',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: SeatView(
          Price: 900,
          className: 'First class',
          date: '2023-09-17',
          maxSeatCount: 3,
          seatCount: 2,
          seet_view: [1, 2],
          train_details: data,
        ),
      ));

      // Verify that HomePage is rendered
      expect(find.text('Front side of train'), findsOneWidget);

      // Verify that CustomAppBar with empty tabs is rendered
      expect(find.text('change root'), findsOneWidget);
    });
  });
}
