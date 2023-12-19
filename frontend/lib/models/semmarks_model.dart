import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SemMarks {
  final String RollNo;
  final String CourseCode;
  final String CourseName;
  final int Ext;
  final int Int;
  final int Total;
  final int GradePoints;
  final String Grade;
  var Credits;
  final double SGPA;
  final double CGPA;
  final String SEM;

  SemMarks({
    required this.RollNo,
    required this.CourseCode,
    required this.CourseName,
    required this.Ext,
    required this.Int,
    required this.Total,
    required this.GradePoints,
    required this.Grade,
    required this.Credits,
    required this.SGPA,
    required this.CGPA,
    required this.SEM,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'RollNo': RollNo,
      'CourseCode': CourseCode,
      'CourseName': CourseName,
      'Ext': Ext,
      'Int': Int,
      'Total': Total,
      'GradePoints': GradePoints,
      'Grade': Grade,
      'Credits': Credits,
      'SGPA': SGPA,
      'CGPA': CGPA,
      'SEM': SEM,
    };
  }

  factory SemMarks.fromMap(Map<String, dynamic> map) {
    return SemMarks(
      RollNo: map['RollNo'] as String,
      CourseCode: map['CourseCode'] as String,
      CourseName: map['CourseName'] as String,
      Ext: map['Ext'] as int,
      Int: map['Int'] as int,
      Total: map['Total'] as int,
      GradePoints: map['GradePoints'] as int,
      Grade: map['Grade'] as String,
      Credits: map['Credits'].toString(),
      SGPA: map['SGPA'] as double,
      CGPA: map['CGPA'] as double,
      SEM: map['SEM'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SemMarks.fromJson(String source) =>
      SemMarks.fromMap(json.decode(source) as Map<String, dynamic>);
}
