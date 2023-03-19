import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/user_model.dart';
import 'package:flutter_application_2/services/session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import '../models/product_model.dart';

class EditUserService {
  String baseUrl = 'https://homecare-api-alt.remorac.com';

  UserModel? userModel;

  Future<List<ProductModel>> getProducts({
    String? email,
    String? name,
    String? nikname,
    String? birtplace,
    String? birhdate,
    String? sex,
    String? provice_id,
    String? distrct_id,
    String? subdistrct_id,
    String? villge_id,
    String? adress,
  }) async {
    var url = '$baseUrl/user/' + userModel!.id.toString();
    var header = {
      'Content-Type': 'application/json',
      'Authorization': '' + await session.getSession()
    };
    var body = jsonEncode(
      {
        'email': email,
        'name': name,
        'nickname': nikname,
        'birthplace': birtplace,
        'birthdate': birhdate,
        'sex': sex,
        'province_id': provice_id,
        'district_id': distrct_id,
        'subdistrict_id': subdistrct_id,
        'village_id': villge_id,
        'address': adress
      },
    );

    var response = await http.get(Uri.parse(url), headers: header);

    print('kumpulan data edit user: ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['user'];
      List<ProductModel> listProducts = [];

      for (var item in data) {
        listProducts.add(ProductModel.fromJson(item));
      }

      return listProducts;
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future uploadImage(filePath) async {
    File image = File(filePath);
    var stream = http.ByteStream(image.openRead());
    stream.cast<List<int>>();

    var length = await image.length();

    var uri = Uri.parse('$baseUrl/user/upload-photo');

    var request = http.MultipartRequest('POST', uri);

    var multiport =
        http.MultipartFile('photo', stream, length, filename: image.path);

    request.headers['Authorization'] = await session.getSession();
    request.files.add(multiport);
    // request.fields['photo'] = 'image';

    var response = await request.send();

    var responseData = await response.stream.toBytes();

    var result = String.fromCharCodes(responseData);

    print(result);
    // print(response.stream.toString());

    if (response.statusCode == 200) {
      print('image uploaded');

      SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Success Upload',
            textAlign: TextAlign.center,
          ));
    } else {
      print('failed');
      throw Exception('Gagal Upload foto');
    }

    // var formData = await http.MultipartFile.fromPath('file', filePath);
    // print(formData.filename);

    // var url = '$baseUrl/user/upload-photo';
    // var header = {'Authorization': '' + await session.getSession()};

    // var response = await http.post(
    //   Uri.parse(url),
    //   headers: header,
    // );
    // var body = jsonEncode(
    //   {'photo': formData.filename},
    // );

    // print('Upload foto: ${response.body}');

    // if (response.statusCode == 200) {
    //   var data = jsonDecode(response.body)['data'];
    //   UserModel user = UserModel.fromJson(data['user']);

    //   return user;
    // } else {
    //   throw Exception('Gagal Upload foto');
    // }
  }
}
