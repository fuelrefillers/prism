import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Attendance {
  var SemPercentage;
  var MonthlyPercentage;
  final int DayPresent;
  Attendance({
    required this.SemPercentage,
    required this.MonthlyPercentage,
    required this.DayPresent,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'SemPercentage': SemPercentage,
      'MonthlyPercentage': MonthlyPercentage,
      'DayPresent': DayPresent,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      SemPercentage: map['SemPercentage'].toString(),
      MonthlyPercentage: map['MonthlyPercentage'].toString(),
      DayPresent: map['DayPresent'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendance.fromJson(String source) =>
      Attendance.fromMap(json.decode(source) as Map<String, dynamic>);
}
