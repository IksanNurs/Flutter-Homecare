import 'package:flutter/material.dart';
import '../models/product_model.dart';

class WishlistProvider with ChangeNotifier {
  List<ProductModel> _itemsWishlist = [];

  List<ProductModel> get itemsWishlist => _itemsWishlist;

  set wishlist(List<ProductModel> items) {
    _itemsWishlist = items;
    notifyListeners();
  }

  setProduct(ProductModel product) {
    if (!isFavorite(product)) {
      _itemsWishlist.add(product);
    } else {
      _itemsWishlist.removeWhere((e) => e.id == product.id);
    }

    notifyListeners();
  }

  isFavorite(ProductModel product) {
    if (_itemsWishlist.indexWhere((e) => e.id == product.id) == -1) {
      return false;
    } else {
      return true;
    }
  }
}
