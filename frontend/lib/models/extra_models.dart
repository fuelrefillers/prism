import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class allAttendanceModel {
  final String date;
  final int PresentStatus;
  allAttendanceModel({
    required this.date,
    required this.PresentStatus,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'PresentStatus': PresentStatus,
    };
  }

  factory allAttendanceModel.fromMap(Map<String, dynamic> map) {
    return allAttendanceModel(
      date: map['date'] as String,
      PresentStatus: map['PresentStatus'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory allAttendanceModel.fromJson(String source) =>
      allAttendanceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class SubjectAttendanceModel {
  final String date;
  final String startTime;
  final String endTime;
  final bool present;
  SubjectAttendanceModel({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.present,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'present': present,
    };
  }

  factory SubjectAttendanceModel.fromMap(Map<String, dynamic> map) {
    return SubjectAttendanceModel(
      date: map['date'] as String,
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
      present: map['present'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectAttendanceModel.fromJson(String source) =>
      SubjectAttendanceModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
