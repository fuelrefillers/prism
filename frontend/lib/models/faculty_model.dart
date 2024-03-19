// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:frontend/models/classes_model.dart';
import 'package:frontend/models/substitute_model.dart';

class Faculty {
  final String FacultyId;
  final String FacultyName;
  final String FacultyDesignation;
  final String FacultyPhnNo;
  final String FacultyDepartment;
  final List<ClassesModel> Classes;
  final bool IsAdmin;
  final List<SubstitueModel> AcceptedSubstitueInfo;
  final List<SubstitueModel> InQueueSubstituteInfo;
  Faculty({
    required this.FacultyId,
    required this.FacultyName,
    required this.FacultyDesignation,
    required this.FacultyPhnNo,
    required this.FacultyDepartment,
    required this.Classes,
    required this.IsAdmin,
    required this.AcceptedSubstitueInfo,
    required this.InQueueSubstituteInfo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'FacultyId': FacultyId,
      'FacultyName': FacultyName,
      'FacultyDesignation': FacultyDesignation,
      'FacultyPhnNo': FacultyPhnNo,
      'FacultyDepartment': FacultyDepartment,
      'Classes': Classes.map((x) => x.toMap()).toList(),
      'IsAdmin': IsAdmin,
      'AcceptedSubstitueInfo':
          AcceptedSubstitueInfo.map((x) => x.toMap()).toList(),
      'InQueueSubstituteInfo':
          InQueueSubstituteInfo.map((x) => x.toMap()).toList(),
    };
  }

  factory Faculty.fromMap(Map<String, dynamic> map) {
    return Faculty(
      FacultyId: map['FacultyId'] as String,
      FacultyName: map['FacultyName'] as String,
      FacultyDesignation: map['FacultyDesignation'] as String,
      FacultyPhnNo: map['FacultyPhnNo'] as String,
      FacultyDepartment: map['FacultyDepartment'] as String,
      Classes: List<ClassesModel>.from(
        (map['Classes'] as List<dynamic>).map<ClassesModel>(
          (x) => ClassesModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      IsAdmin: map['IsAdmin'] as bool,
      AcceptedSubstitueInfo: List<SubstitueModel>.from(
        (map['AcceptedSubstitueInfo'] as List<dynamic>).map<SubstitueModel>(
          (x) => SubstitueModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      InQueueSubstituteInfo: List<SubstitueModel>.from(
        (map['InQueueSubstituteInfo'] as List<dynamic>).map<SubstitueModel>(
          (x) => SubstitueModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Faculty.fromJson(String source) =>
      Faculty.fromMap(json.decode(source) as Map<String, dynamic>);
}
