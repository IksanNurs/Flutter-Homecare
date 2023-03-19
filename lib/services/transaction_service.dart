import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/cart_model.dart';

class TransactionService {
  String baseUrl = 'YOUR-API-HERE';

  Future<bool> transaction(
      String token, List<CartModel> carts, double totalPrice) async {
    var url = '$baseUrl/checkout';
    var header = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var body = jsonEncode({
      'address': 'Kota Biak',
      'items': carts
          .map((cart) => {
                'id': cart.product!.id,
                'quantity': cart.quantity,
              })
          .toList(),
      'status': 'PENDING',
      'total_price': totalPrice,
      'shipping_price': 0,
    });

    print('isi body: ${body}');

    var response = await http.post(Uri.parse(url), headers: header, body: body);
    print('data checkout: ${response.body}');

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to checkout');
    }
  }
}
