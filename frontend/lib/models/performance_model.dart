import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Performance {
  final String rollno;
  final int mid;
  final int mid_scored;
  final double cgpa;
  final List<dynamic> previous_cgpa;
  final int backlogs;
  Performance({
    required this.rollno,
    required this.mid,
    required this.mid_scored,
    required this.cgpa,
    required this.previous_cgpa,
    required this.backlogs,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rollno': rollno,
      'mid': mid,
      'mid_scored': mid_scored,
      'cgpa': cgpa,
      'previous_cgpa': previous_cgpa,
      'backlogs': backlogs,
    };
  }

  factory Performance.fromMap(Map<String, dynamic> map) {
    return Performance(
      rollno: map['rollno'] as String,
      mid: map['mid'] as int,
      mid_scored: map['mid_scored'] as int,
      cgpa: map['cgpa'] as double,
      previous_cgpa:
          List<dynamic>.from((map['previous_cgpa'] as List<dynamic>)),
      backlogs: map['backlogs'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Performance.fromJson(String source) =>
      Performance.fromMap(json.decode(source) as Map<String, dynamic>);
}
