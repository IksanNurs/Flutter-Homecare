import 'dart:convert';

import 'package:flutter_application_2/models/province.dart';
import 'package:flutter_application_2/models/user_model.dart';
import 'package:flutter_application_2/services/session_manager.dart';
import 'package:http/http.dart' as http;

class ProvinceService {
  String baseUrl = 'https://homecare-api-alt.remorac.com';

  UserModel? userModel;

  Future<List<ProvinceModel>> getProvinces() async {
    var url = '$baseUrl/province';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': '' + await session.getSession()
    };

    var response = await http.get(Uri.parse(url), headers: header);

    print('kumpulan data provinces: ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['provinces'];
      List<ProvinceModel> listProvince = [];

      for (var item in data) {
        listProvince.add(ProvinceModel.fromJson(item));
      }

      return listProvince;
    } else {
      throw Exception('Failed to load provinces');
    }
  }
}
