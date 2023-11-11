import 'package:flutter/material.dart';
import 'package:frontend/screens/books_screen.dart';

class ProductFavoriteController with ChangeNotifier {
  final List<Books> _products = [];
  List<Books> get products => _products;

  void addToWishlist(Books product) {
    _products.add(product);
    notifyListeners();
  }

  void removeFromWishlist(Books product) {
    _products.remove(product);
    notifyListeners();
  }
}
