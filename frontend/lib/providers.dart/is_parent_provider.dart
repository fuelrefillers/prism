import 'package:flutter/material.dart';

class IsParentLoggedIn extends ChangeNotifier {
  bool isSignedIn = false;
  changeStatus() {
    isSignedIn = !isSignedIn;
    notifyListeners();
  }
}
