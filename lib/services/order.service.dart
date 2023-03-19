import 'dart:convert';

import 'package:flutter_application_2/models/user_model.dart';
import 'package:flutter_application_2/services/session_manager.dart';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class OrderService {
  String baseUrl = 'https://homecare-api-alt.remorac.com';

  UserModel? userModel;

  Future<List<ProductModel>> getProducts() async {
    var url = '$baseUrl/service';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': '' + await session.getSession()
    };

    var response = await http.get(Uri.parse(url), headers: header);

    print('kumpulan data product: ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['orders'];
      List<ProductModel> listProducts = [];

      for (var item in data) {
        listProducts.add(ProductModel.fromJson(item));
      }

      return listProducts;
    } else {
      throw Exception('Failed to load orders');
    }
  }
}
