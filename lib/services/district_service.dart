import 'dart:convert';

import 'package:flutter_application_2/models/district.dart';
import 'package:flutter_application_2/models/user_model.dart';
import 'package:flutter_application_2/services/session_manager.dart';
import 'package:http/http.dart' as http;

class DistricsService {
  String baseUrl = 'https://homecare-api-alt.remorac.com';

  UserModel? userModel;

  Future<List<DistricModel>> getDistrics({String? id}) async {
    var url = '$baseUrl/district?province_id=' + id.toString();
    var header = {
      'Content-Type': 'application/json',
      'Authorization': '' + await session.getSession()
    };

    var response = await http.get(Uri.parse(url), headers: header);

    print('kumpulan data districs: ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['districts'];
      List<DistricModel> listDistrics = [];

      for (var item in data) {
        listDistrics.add(DistricModel.fromJson(item));
      }

      return listDistrics;
    } else {
      throw Exception('Failed to load districs');
    }
  }
}
