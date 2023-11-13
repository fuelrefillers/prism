import 'package:flutter/material.dart';
import 'package:frontend/models/attendance_model.dart';

class AttendanceProvider extends ChangeNotifier {
  Attendance _attendance = Attendance(
      rollno: '',
      present_day: 0,
      total_classes: 0,
      total_atended_classes: 0,
      monthly_classes: 0,
      monthly_attended_classes: 0);

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
