import 'package:flutter/material.dart';

class isErrorProvider extends ChangeNotifier {
  bool isError = false;
  changeStatus() {
    isError = !isError;
    notifyListeners();
  }
}
