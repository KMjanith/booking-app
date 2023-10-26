import 'package:booking_app/Pages/widgets/drawer.dart';
import 'package:booking_app/servises/AuthManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {


  testWidgets(
      'Testing drawer when a customer has logged in',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        drawer: CustomDrawer(),
      ),
    ));

    AuthManager.login();
    // Verify that CustomAppBar with empty tabs is rendered
    expect(find.text('Cancel Booking'), findsNothing);
    expect(find.text('See Qr'), findsNothing);
    expect(find.text('My Profile'), findsNothing);
    expect(find.text('Log Out'), findsNothing);
  });

   testWidgets('Testing drawer when a customer has logged Out',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        drawer: CustomDrawer(),
      ),
    ));

    AuthManager.login();
    // Verify that CustomAppBar with empty tabs is rendered
    expect(find.text('Login'), findsNothing);
    expect(find.text('Sign Up'), findsNothing);
    expect(find.text('Cancel Booking'), findsNothing);
    expect(find.text('See Qr'), findsNothing);
  });
}
