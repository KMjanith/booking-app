import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:booking_app/main.dart' as app;
import 'package:quickalert/quickalert.dart'; // Import your app's main file

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login flow test', (WidgetTester tester) async {
    app.main(); // Start your app
    await tester.pumpAndSettle(); // Wait for the app to fully load

    // Perform login actions (enter username and password, press login button)
    await tester.enterText(find.byKey(Key('emailInput')), 'test_user');
    await tester.enterText(
        find.byKey(Key('passwordInput')), 'test_password');
    await tester.tap(find.byKey(Key('loginButton')));
    await tester.pumpAndSettle(); // Wait for the login process to complete

    // Verify QuickAlert dialog
    //expect(find.text('Successfully logged in'), findsOneWidget);

    // Tap the confirm button in the QuickAlert dialog
    await tester.tap(find.byElementType(QuickAlert() as Type));;
    await tester.pumpAndSettle(); // Wait for the navigation to complete

    // Verify that the app navigated to the home page
    expect(find.text('Welcome to Home Page'), findsOneWidget);
  });
}
