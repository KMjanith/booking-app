import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constant.dart';


class SerachTrain {
  static const String baseUrl = '$baseUrl_1/Search';

  Future<List<Map<String, dynamic>>> getTrains(String from, String to,
      String date, int passengers, String returnDate) async {
    final Map<String, dynamic> requestBody = {
      'from': from,
      'to': to,
      'date': date,
      'passengers': passengers,
      //"returnDate": returnDate
    };

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody), // Encode the map as JSON
    );

    //print(response.body);
    // List<String> errormessage =
    //     json.decode(response.body); //convert result string in to a Map
    // print(errormessage);
    List<dynamic> decodedJson = json.decode(response.body);
    //print(decodedJson[0]);
    //print(decodedJson[1]);

    final classPrices = {"ticketPrices": decodedJson[1]};

    decodedJson[0].add(classPrices);
    //print(decodedJson[0].runtimeType);
    List<Map<String, dynamic>> finalTrains = [];
    for (int i = 0; i < decodedJson[0].length; i++) {
      finalTrains.add(decodedJson[0][i]);
    }
    // print(decodedJson[0][0]);
    // print(decodedJson[0][1]);
    // print(decodedJson[0][2]);
    //print(finalTrains[0]["trainName"]);
    //print(finalTrains.runtimeType);
    return finalTrains;
  }
}
