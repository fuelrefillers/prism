// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HostelStudentModel {
  final String Id;
  final String name;
  HostelStudentModel({
    required this.Id,
    required this.name,
  });
}

class HostelProvider extends ChangeNotifier {
  HostelStudentModel _hostelStudentModel = HostelStudentModel(Id: "", name: "");

  HostelStudentModel get hostelStudent => _hostelStudentModel;

  void setHoselStudentFromModel(HostelStudentModel stu) {
    _hostelStudentModel = stu;
    notifyListeners();
  }
}
