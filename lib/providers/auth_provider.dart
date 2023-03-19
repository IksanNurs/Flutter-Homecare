import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/request.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel _userModel = UserModel();
  // UserModel? _userModel1;

  UserModel get userModel => _userModel;

  set userModel(UserModel userModel) {
    _userModel = userModel;
    notifyListeners();
  }

  Future<bool> register({
    String? phone,
    String? username,
    String? email,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        phone: phone,
        username: username,
        email: email,
        password: password,
      );

      _userModel = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({
    String? phone,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        phone: phone,
        password: password,
      );

      _userModel = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> loginToken() async {
    try {
      UserModel user = await AuthService().loginToken();

      _userModel = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> requestPassword({
    String? emailphone,
  }) async {
    try {
      await AuthService().requestPassword(
        emailphone: emailphone,
      );

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> resetPassword({String? tokenReset, String? passwordbaru}) async {
    try {
      await AuthService().resetPassword(
        tokenReset: tokenReset,
        passwordBaru: passwordbaru,
      );

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
