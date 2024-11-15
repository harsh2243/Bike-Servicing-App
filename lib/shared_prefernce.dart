


import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  // Method to save user data
  Future<void> saveUser(String name, String mobile, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('mobile', mobile);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  // Method to retrieve user data
  Future<Map<String, String?>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('name'),
      'mobile': prefs.getString('mobile'),
      'email': prefs.getString('email'),
      'password': prefs.getString('password'),
    };
  }
}
