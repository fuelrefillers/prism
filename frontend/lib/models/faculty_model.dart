// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Faculty {
  final String FacultyId;
  final String FacultyName;
  final String FacultyDesignation;
  final String FacultyPhnNo;
  final List<dynamic> Classes;
  final bool IsAdmin;
  Faculty({
    required this.FacultyId,
    required this.FacultyName,
    required this.FacultyDesignation,
    required this.FacultyPhnNo,
    required this.Classes,
    required this.IsAdmin,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'FacultyId': FacultyId,
      'FacultyName': FacultyName,
      'FacultyDesignation': FacultyDesignation,
      'FacultyPhnNo': FacultyPhnNo,
      'classes': Classes,
      'IsAdmin': IsAdmin,
    };
  }

  factory Faculty.fromMap(Map<String, dynamic> map) {
    return Faculty(
      FacultyId: map['FacultyId'] as String,
      FacultyName: map['FacultyName'] as String,
      FacultyDesignation: map['FacultyDesignation'] as String,
      FacultyPhnNo: map['FacultyPhnNo'] as String,
      Classes: List<dynamic>.from(map['Classes'] as List<dynamic>),
      IsAdmin: map['IsAdmin'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Faculty.fromJson(String source) =>
      Faculty.fromMap(json.decode(source) as Map<String, dynamic>);
}
