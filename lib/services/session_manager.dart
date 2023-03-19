import 'package:flutter_application_2/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  String? tokenUser;

  Future<void> saveSession(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token ?? "");
  }

  Future getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tokenUser = prefs.getString('token');
    return tokenUser ?? "";
  }

  Future clearSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}

final session = SessionManager();
