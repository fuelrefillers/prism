import 'package:flutter/material.dart';
import 'package:frontend/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      Regulation: "",
      StudentName: "",
      StudentPhnNo: '',
      StudentEmail: '',
      FatherName: '',
      FatherPhnNo: '',
      FatherEmail: '',
      MotherName: '',
      MotherPhnNo: '',
      MotherEmail: '',
      RollNo: '',
      ImageUrl: '',
      Semester: 0,
      Department: '',
      Section: '',
      Actions: '',
      FeeStatus: false);

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
  }
}
