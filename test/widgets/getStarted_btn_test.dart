import 'package:booking_app/Pages/procedure/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('Book Your Train Today!" is rendered',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: HomePage(),
    ));

    // Verify that HomePage is rendered
    expect(find.text("Book Your\nTrain Today!"), findsOneWidget);

    // Tap the button to navigate to SecondPage
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle(const Duration(
        seconds: 2)); // Wait for the navigation transition to complete

    // Verify that SecondPage is rendered after navigation
    expect(find.text('Pick Your Way'), findsOneWidget);
    expect(
        find.text(
            'Select your origin, destination, date and number of passengers. All field must be fill to check available trains'),
        findsOneWidget);
  });

  //nav bar tapping test
  testWidgets('testing for seat view page rendering', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: HomePage(),
    ));

    // Verify that HomePage is rendered
    expect(find.text("Book Your\nTrain Today!"), findsOneWidget);

    // Tap the button to navigate to SecondPage
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle(const Duration(
        seconds: 2)); // Wait for the navigation transition to complete

    // Verify that SecondPage is rendered after navigation
    expect(find.text('Pick Your Way'), findsOneWidget);
    expect(
        find.text(
            'Select your origin, destination, date and number of passengers. All field must be fill to check available trains'),
        findsOneWidget);
  });



}
