import 'package:flutter/material.dart';

class isLoadinProvider extends ChangeNotifier {
  bool isloading = false;
  bool isloadingstudent = false;
  bool isloadingparent = false;
  bool isloadingsfaculty = false;

  changeStatus() {
    isloading = !isloading;
    notifyListeners();
  }

  void toggleStudentLoading() {
    isloadingstudent = !isloadingstudent;
    notifyListeners();
  }

  void toggleParentLoading() {
    isloadingparent = !isloadingparent;
    notifyListeners();
  }

  void toggleFacultyLoading() {
    isloadingsfaculty = !isloadingsfaculty;
    notifyListeners();
  }
}
