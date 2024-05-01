import 'package:flutter/material.dart';
import 'package:frontend/models/faculty_time_table_model.dart';
import 'package:frontend/models/time_table_view_model.dart';

class TimeTableViewProvider with ChangeNotifier {
  List<TimeTableView> _timeTableViews = [];

  List<TimeTableView> get timeTableViews => _timeTableViews;

  void setFromModel(List<TimeTableView> timeTableViews) {
    _timeTableViews = timeTableViews;
    notifyListeners();
  }
}

class FacultyTimeTableProvider with ChangeNotifier {
  FacultyTimeTable _facultyTimeTable = FacultyTimeTable(
      FacultyId: "--",
      FacultyName: "--",
      FacultyDepartment: "--",
      TimeTable: []);
  FacultyTimeTable get facultyTimeTable => _facultyTimeTable;

  void setFromModel(FacultyTimeTable facultyTimeTable) {
    _facultyTimeTable = facultyTimeTable;
  }
}
