import 'package:flutter/material.dart';

class IsfacultyLoggedIn extends ChangeNotifier {
  bool isSignedIn = false;
  changeStatus() {
    isSignedIn = !isSignedIn;
    notifyListeners();
  }
}
