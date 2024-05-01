import 'package:flutter/material.dart';
import 'package:frontend/models/performance_model.dart';

class PerformanceProvider extends ChangeNotifier {
  Performance _performance = Performance(
      RollNo: '',
      MidTotal: [0],
      MidScored: [0],
      CGPA: '',
      PreviousSGPA: [0],
      Backlogs: [''],
      TotalSub: 0);

  Performance get performance => _performance;

  void setPerformance(String performance) {
    _performance = Performance.fromJson(performance);
    notifyListeners();
  }

  void setPerformanceFromModel(Performance performance) {
    _performance = performance;
    notifyListeners();
  }
}
