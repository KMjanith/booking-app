import 'package:booking_app/Models/Trainmodel.dart';
import 'package:booking_app/Pages/procedure/CustomerDetails.dart';
import 'package:booking_app/servises/Cancel_api.dart';
import 'package:booking_app/servises/login_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'API_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.

class MockBuildContext extends Mock implements BuildContext {}

// ignore: invalid_annotation_target
@Timeout(Duration(seconds: 45))
@GenerateMocks([http.Client])
void main() {
  ApiServiceLogin apiservice = ApiServiceLogin();
  CancelBookingApi cancel = CancelBookingApi();

  group("back end Api calling testing/ Log in functionality", () {
    //login API call

    test("returns an token if the http call completes successfully in login",
        () async {
      final client = MockClient();
      final mockContext = MockBuildContext();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.post(Uri.parse(
              'https://stage-pilot-train-booking-system.onrender.com/login')))
          .thenAnswer((_) async => http.Response(
              '{"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTI2NWMxY2YyODY2NzE1YmMzNmM1MTMiLCJpc0FkbWluIjpmYWxzZSwiaWF0IjoxNjk3MzY1MDUzfQ.FwXNYY1K4eaU8z1RZRUS_w99GaWmTr8yQ8PW7krLBh4","isAdmin":false,"userID":"65265c1cf2866715bc36c513"}',
              200));

      final login = await apiservice.login(
          mockContext, "kavindujanith4436@gmail.com", "123456789", client);
      expect(login, 200);
    });
  });


  group("back end Api calling testing/ cancel booking", () {

    //this test is for searching the ticket
    test(
        "this will return the booking details if the http call completes successfully in cancel booking",
        () async {
      final client = MockClient();
      final mockContext = MockBuildContext();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.post(Uri.parse(
              'https://stage-pilot-train-booking-system.onrender.com/refund')))
          .thenAnswer((_) async => http.Response(
              ' {"refund":0,"daysRemaining":-41,"booking":{"_id":"6503fec2a3528af89e2b03b6","ReferenceNo":"TBS/20230915/122042","firstName":"kavindu","lastName":"janith","mobile":"0770506463","email":"kavindujanith4436@gmail.com","NIC":"991332626v","passengerCount":2,"trainName":"Train 1","from":"A","to":"I","date":"2023-09-15","price":"1400","seat_numbers":["10","11"],"class":"Second class","timeFrom":"8.25AM","timeTo":"7.25AM","Status":"Pending","__v":0}}',
              200));

      final cancelation = await cancel.cancelBooking(
          mockContext, "TBS/20230915/122042", client);

      expect(cancelation, {
        'statusCode': 200,
        'body':
            '{"refund":0,"daysRemaining":-41,"booking":{"_id":"6503fec2a3528af89e2b03b6","ReferenceNo":"TBS/20230915/122042","firstName":"kavindu","lastName":"janith","mobile":"0770506463","email":"kavindujanith4436@gmail.com","NIC":"991332626v","passengerCount":2,"trainName":"Train 1","from":"A","to":"I","date":"2023-09-15","price":"1400","seat_numbers":["10","11"],"class":"Second class","timeFrom":"8.25AM","timeTo":"7.25AM","Status":"Pending","__v":0}}'
      });
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


    // this test is when users is a logged user then customer details will automatically fill
    test('fills input fields with user data when user ID is provided',
        () async {
      final client = MockClient();

      // Mock HTTP response when calling the API endpoint
      when(client.post(
              Uri.parse(
                  'https://stage-pilot-train-booking-system.onrender.com/popupform'),
              headers: anyNamed('headers'),
              body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
                '{"firstName":"kavindu","lastName":"janith","email":"kavindujanith4436@gmail.com","NIC":"991332626v","mobile":"0770506463"}',
                200,
              ));

      final customerDetails = CustomerDetails(
        Seatnumbers: ['1', '2'],
        date: "2023-19-17",
        passengerCount: 3,
        price: 900,
        train_details: data,
        updatedSeatView: [0, 0, 0, 1, 0, 1, 0, 1],
      );

      // Call the method to fill input fields
      await customerDetails.loginDetails('65265c1cf2866715bc36c513');

      // Expect input fields to be filled with mock data
      expect(customerDetails.firstName.text, 'kavindu');
      expect(customerDetails.lastName.text, 'janith');
      expect(customerDetails.email.text, 'kavindujanith4436@gmail.com');
      expect(customerDetails.NIC.text, '991332626v');
      expect(customerDetails.mobile.text, '0770506463');
    });
  });
}
