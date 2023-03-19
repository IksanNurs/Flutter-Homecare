import 'package:flutter/material.dart';
import '../services/product_service.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  int _quantity = 1;
  int _value = 10;
  int get quantity => _quantity;
  int get value => _value;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  Future<void> getProducts() async {
    try {
      List<ProductModel> products = await ProductService().getProducts();
      _products = products;
    } catch (e) {
      // print(e);
    }
  }

  set quantity(int newValue) {
    _quantity = newValue;
    notifyListeners();
  }

  set value(int newValue) {
    _value = newValue;
    notifyListeners();
  }
}
