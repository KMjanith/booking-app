import 'package:booking_app/Pages/procedure/Home.dart';
import 'package:booking_app/Pages/procedure/take_inputs_page.dart';
import 'package:booking_app/Pages/widgets/input_fields/normal_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  bool findNormalInputWidget(Widget widget) {
    return widget is NormalInput &&
        widget.labelText == 'pasengers' &&
        widget.obscureText == false &&
        widget.icon.icon == const Icon(Icons.person) &&
        widget.keyboardType == TextInputType.number;
  }
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

  testWidgets('Test NormalInput widgets in FirstPage',
      (WidgetTester tester) async {
    // Build your widget tree
    await tester.pumpWidget(MaterialApp(
      home: FirstPage(),
    ));

    // Find the first NormalInput widget by its key
    final firstInputFinder = find.byKey(Key('passengerInput'));
    // Verify if the first NormalInput widget exists
    expect(firstInputFinder, findsWidgets);

    

    // Perform interactions with the NormalInput widgets
    await tester.enterText(firstInputFinder, 'Text for first input');
     // Verify that the TextField now contains the entered text
    expect(find.text('Text for first input'), findsWidgets);
  });

   testWidgets('Test DropDoen widgets in FirstPage',
      (WidgetTester tester) async {
    // Build your widget tree
    await tester.pumpWidget(MaterialApp(
      home: FirstPage(),
    ));

    // Find the first NormalInput widget by its key
    final firstInputFinder = find.byKey(Key('fromInput'));
    final secondInputFinder = find.byKey(Key('toInput'));
    // Verify if the first NormalInput widget exists
    expect(firstInputFinder, findsWidgets);
    expect(secondInputFinder, findsWidgets);
    final loginbtn = find.byKey(const Key("Loginbtn"));
    expect(loginbtn, findsWidgets);

    
  });

}
