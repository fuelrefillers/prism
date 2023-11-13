import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Attendance {
  final String rollno;
  final int present_day;
  final int total_classes;
  final int total_atended_classes;
  final int monthly_classes;
  final int monthly_attended_classes;
  Attendance({
    required this.rollno,
    required this.present_day,
    required this.total_classes,
    required this.total_atended_classes,
    required this.monthly_classes,
    required this.monthly_attended_classes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rollno': rollno,
      'present_day': present_day,
      'total_classes': total_classes,
      'total_atended_classes': total_atended_classes,
      'monthly_classes': monthly_classes,
      'monthly_attended_classes': monthly_attended_classes,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      rollno: map['rollno'] as String,
      present_day: map['present_day'] as int,
      total_classes: map['total_classes'] as int,
      total_atended_classes: map['total_atended_classes'] as int,
      monthly_classes: map['monthly_classes'] as int,
      monthly_attended_classes: map['monthly_attended_classes'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendance.fromJson(String source) =>
      Attendance.fromMap(json.decode(source) as Map<String, dynamic>);
}
