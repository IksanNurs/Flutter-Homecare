import 'dart:convert';

import 'package:flutter_application_2/models/district.dart';
import 'package:flutter_application_2/models/subdistrict.dart';
import 'package:flutter_application_2/models/user_model.dart';
import 'package:flutter_application_2/services/session_manager.dart';
import 'package:http/http.dart' as http;

class SubdistricService {
  String baseUrl = 'https://homecare-api-alt.remorac.com';

  UserModel? userModel;

  Future<List<SubdistrictModel>> getSubDistrics({String? id}) async {
    var url = '$baseUrl/subdistrict?district_id=' + id.toString();
    var header = {
      'Content-Type': 'application/json',
      'Authorization': '' + await session.getSession()
    };

    var response = await http.get(Uri.parse(url), headers: header);

    print('kumpulan data subdistrics: ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['subdistricts'];
      List<SubdistrictModel> listSubdistrics = [];

      for (var item in data) {
        listSubdistrics.add(SubdistrictModel.fromJson(item));
      }

      return listSubdistrics;
    } else {
      throw Exception('Failed to load subdistrics');
    }
  }
}
