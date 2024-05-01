import 'package:flutter/material.dart';

class whoIsSignedIn extends ChangeNotifier {
  String isSignedIn = "";
  changeStatus(String isss) {
    isSignedIn = isss;
  }
}
