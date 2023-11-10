import 'package:flutter/material.dart';
import 'package:frontend/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      rollno: '',
      name: '',
      branch: '',
      clas: '',
      studentphno: '',
      studentemail: '',
      parentname: '',
      parentphno: '',
      parentemail: '');

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
