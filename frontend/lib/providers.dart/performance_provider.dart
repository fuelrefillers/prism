import 'package:flutter/material.dart';
import 'package:frontend/models/performance_model.dart';

class PerformanceProvider extends ChangeNotifier {
  Performance _performance = Performance(
      rollno: '',
      mid: 0,
      mid_scored: 0,
      cgpa: 0,
      previous_cgpa: [0],
      backlogs: 0);

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
