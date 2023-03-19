import 'dart:convert';

import 'package:flutter_application_2/models/district.dart';
import 'package:flutter_application_2/models/user_model.dart';
import 'package:flutter_application_2/models/village.dart';
import 'package:flutter_application_2/services/session_manager.dart';
import 'package:http/http.dart' as http;

class VillageService {
  String baseUrl = 'https://homecare-api-alt.remorac.com';

  UserModel? userModel;

  Future<List<VillagesModel>> getVillages({String? id}) async {
    var url = '$baseUrl/village?subdistrict_id=' + id.toString();
    var header = {
      'Content-Type': 'application/json',
      'Authorization': '' + await session.getSession()
    };

    var response = await http.get(Uri.parse(url), headers: header);

    print('kumpulan data villages: ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['villages'];
      List<VillagesModel> listVillages = [];

      for (var item in data) {
        listVillages.add(VillagesModel.fromJson(item));
      }

      return listVillages;
    } else {
      throw Exception('Failed to load villages');
    }
  }
}
