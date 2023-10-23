//import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static bool isLoggedIn = false;
  static  String tokens = '';
  //static  String _tokenKey = tokens;
  

  static void login() {
    // Perform login logic
    isLoggedIn = true;
  }

  static void logout() {
    // Perform logout logic
    isLoggedIn = false;
  }

  // static Future<void> saveToken(String token) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(_tokenKey, token);
  // }

  // static Future<String?> getToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_tokenKey);
  // }

  // static Future<void> logoutStorage() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.remove(_tokenKey);
  // }
}
