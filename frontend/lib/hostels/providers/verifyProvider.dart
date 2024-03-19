import 'package:flutter/material.dart';
// import 'package:host/models/verify.dart';
import 'package:frontend/hostels/models/verify.dart';

class VerifyProvider extends ChangeNotifier {
  Verify? _verify;

  Verify? get verify => _verify;

  void setVerify(Verify verify) {
    _verify = verify;
    notifyListeners();
  }

  void clearVerify() {
    _verify = null;
    notifyListeners();
  }
}
