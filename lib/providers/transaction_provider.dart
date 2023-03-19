import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../services/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
  Future<bool> transaction(
      String token, List<CartModel> carts, double totalPrice) async {
    try {
      if (await TransactionService().transaction(token, carts, totalPrice)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('error is ${e}');
      return false;
    }
  }
}
