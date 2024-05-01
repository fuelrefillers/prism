import 'package:flutter/material.dart';

class UploadPercentageProvider extends ChangeNotifier {
  double _progress = 0.00;

  double get progress => _progress;

  void setprogress(double value) {
    _progress = value;
    notifyListeners();
  }
}
