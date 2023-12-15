import 'package:flutter/material.dart';
import 'package:frontend/models/attendance_model.dart';

class AttendanceProvider extends ChangeNotifier {
  Attendance _attendance =
      Attendance(SemPercentage: 0.00, MonthlyPercentage: 0.00, DayPresent: 0);

  Attendance get attendance => _attendance;

  void setAttendance(String attendance) {
    _attendance = Attendance.fromJson(attendance);
    notifyListeners();
  }

  void setAttendanceFromModel(Attendance attendance) {
    _attendance = attendance;
    notifyListeners();
  }
}
