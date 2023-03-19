import 'dart:convert';

import 'package:flutter_application_2/models/request.dart';
import 'package:flutter_application_2/services/session_manager.dart';

import '../models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String UrlBase = 'https://homecare-api-alt.remorac.com';

  Future<UserModel> register({
    String? phone,
    String? username,
    String? email,
    String? password,
  }) async {
    var url = '$UrlBase/auth/signup';
    var header = {
      'Content-Type': 'application/json',
    };

    var body = jsonEncode(
      {
        'phone': phone,
        'username': username,
        'email': email,
        'password': password,
      },
    );

    var response = await http.post(Uri.parse(url), headers: header, body: body);

    print('kumpulan data: ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['token'];
      session.saveSession(user.token);

      return user;
    } else {
      throw Exception('Gagal register');
    }
  }

  Future<UserModel> login({
    String? phone,
    String? password,
  }) async {
    var url = '$UrlBase/auth/login';
    var header = {
      'Content-Type': 'application/json',
    };

    var body = jsonEncode(
      {
        'phone': phone,
        'password': password,
      },
    );

    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );

    print('kumpulan data login: ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['token'];
      session.saveSession(user.token);

      return user;
    } else {
      throw Exception('Gagal login');
    }
  }

  Future<UserModel> loginToken() async {
    var url = '$UrlBase/user/self';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': '' + await session.getSession()
    };

    var response = await http.get(
      Uri.parse(url),
      headers: header,
    );

    print('kumpulan data login: ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = '' + await session.getSession();

      return user;
    } else {
      throw Exception('Gagal login');
    }
  }

  Future requestPassword({
    String? emailphone,
  }) async {
    var url = '$UrlBase/auth/request-password-reset';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': '' + await session.getSession()
    };
    var body = jsonEncode(
      {
        'email_or_phone': emailphone,
      },
    );

    var response = await http.put(Uri.parse(url), headers: header, body: body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Request Password');
    }
  }

  Future resetPassword({String? tokenReset, String? passwordBaru}) async {
    var url = '$UrlBase/auth/reset-password?password_reset_token=' +
        tokenReset.toString();
    var header = {
      'Content-Type': 'application/json',
      'Authorization': '' + await session.getSession()
    };
    var body = jsonEncode(
      {
        'password': passwordBaru,
      },
    );

    var response = await http.put(Uri.parse(url), headers: header, body: body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Reset Password');
    }
  }
}
