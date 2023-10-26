import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/item.dart';
import 'constant.dart';

class ApiService {
  static const String baseUrl = '$baseUrl_1/register';

  Future<Map<String, dynamic>> addItem(Item item, http.Client client) async {
    final response = await http.post(
      Uri.parse('$baseUrl'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(item.toJson()),
    );

    print(response.body);

    final result = {"statusCode": response.statusCode, "body": response.body};
    return result;
  }
}
