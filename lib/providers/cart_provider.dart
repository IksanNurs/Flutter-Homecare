import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _carts = [];

  List<CartModel> get cart => _carts;

  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  addToCart(ProductModel product) {
    if (cartExist(product)) {
      int index = _carts.indexWhere((e) => e.product!.id == product.id);
      _carts[index].quantity++;
    } else {
      _carts.add(CartModel(id: _carts.length, product: product, quantity: 1));
    }

    notifyListeners();
  }

  removeCart(int id) {
    _carts.removeAt(id);
    notifyListeners();
  }

  addQty(int id) {
    _carts[id].quantity++;
    notifyListeners();
  }

  reduceQty(int id) {
    _carts[id].quantity--;

    if (_carts[id].quantity == 0) {
      _carts.removeAt(id);
    }

    notifyListeners();
  }

  totalItems() {
    int total = 0;
    _carts.forEach((e) {
      total += e.quantity;
    });
    return total;
  }

  totalPrice() {
    double total = 0;
    _carts.forEach((e) {
      total += e.product!.price! * e.quantity;
    });
    return total;
  }

  cartExist(ProductModel product) {
    if (_carts.indexWhere((e) => e.product!.id == product.id) == -1) {
      return false;
    } else {
      return true;
    }
  }
}
