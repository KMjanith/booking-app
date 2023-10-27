import 'package:booking_app/Pages/procedure/take_inputs_page.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  FirstPage takeInput = FirstPage();

  group("Date selection checker", () {
    test(
        "given date as a String when taking inputs then return a List<String> returning ['Daily','Weekends'] or ['Daily,'Weekdays]",
        () {
      List<String> dates = takeInput.DateTake('2023-10-19');
      expect(dates, ['Daily', 'Weekdays']);
    });

    test(
        "given date as a String when taking inputs then return a List<String> returning ['Daily','Weekends'] or ['Daily,'Weekdays]",
        () {
      List<String> dates = takeInput.DateTake('2023-10-22');
      expect(dates, ['Daily', 'Weekends']);
    });
  });



  
}
