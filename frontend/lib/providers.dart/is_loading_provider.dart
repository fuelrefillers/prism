import 'package:flutter/material.dart';

class isLoadinProvider extends ChangeNotifier {
  bool isloading = false;
  changeStatus() {
    isloading = !isloading;
    notifyListeners();
  }
}
