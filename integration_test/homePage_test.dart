import 'package:booking_app/Pages/procedure/take_inputs_page.dart';
import 'package:booking_app/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("take inputs error state testing", () {
    testWidgets(
        "testing for the error when all inputs are not properly entered",
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final getStarted = find.byKey(const Key("getStarted"));
      //await tester.pumpAndSettle(Duration(seconds: 1)); // Wait for 1 second
      await tester.tap(getStarted);

      await tester.pumpAndSettle(); // Wait for 1 second
      await tester.enterText(find.byKey(Key("passengerInput")), "2");

      final availableTrains = find.byKey(const Key("available_trains"));
      await tester.tap(availableTrains);
      await tester.pumpAndSettle(Duration(seconds: 1)); // Wait for 1 second
      expect(find.byType(FirstPage), findsWidgets);
    });

    testWidgets(
        "testing for going take input page -> Login Page -> Sign up page",
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final getStarted = find.byKey(const Key("getStarted"));
      //await tester.pumpAndSettle(Duration(seconds: 1)); // Wait for 1 second
      await tester.tap(getStarted);
      await tester.pumpAndSettle(); // Wait for 1 second

      final loginbtn = find.byKey(const Key("Loginbtn"));
      // expect(loginbtn, findsWidgets);
      await tester.tap(loginbtn);
      await tester.pumpAndSettle(Duration(seconds: 1)); // Wait for 1 second
      expect(find.text("Log in"), findsWidgets);

      final SignUpnbtn = find.byKey(const Key("Signupbtn"));
      // expect(loginbtn, findsWidgets);
      await tester.tap(SignUpnbtn);
      await tester.pumpAndSettle(Duration(seconds: 1)); // Wait for 1 second
      expect(find.text("Sign up"), findsWidgets);
    });
  });
}
