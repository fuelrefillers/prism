import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Performance {
  final String RollNo;
  final List<dynamic> MidTotal;
  final List<dynamic> MidScored;
  var CGPA;
  final List<dynamic> PreviousSGPA;
  final List<dynamic> Backlogs;
  final int TotalSub;
  Performance({
    required this.RollNo,
    required this.MidTotal,
    required this.MidScored,
    required this.CGPA,
    required this.PreviousSGPA,
    required this.Backlogs,
    required this.TotalSub,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'RollNo': RollNo,
      'MidTotal': MidTotal,
      'MidScored': MidScored,
      'CGPA': CGPA,
      'PreviousSGPA': PreviousSGPA,
      'Backlogs': Backlogs,
      'TotalSub': TotalSub,
    };
  }

  factory Performance.fromMap(Map<String, dynamic> map) {
    return Performance(
      RollNo: map['RollNo'] as String,
      MidTotal: List<dynamic>.from(map['MidTotal'] as List<dynamic>),
      MidScored: List<dynamic>.from(map['MidScored'] as List<dynamic>),
      CGPA: map['CGPA'].toString(),
      PreviousSGPA: List<dynamic>.from(map['PreviousSGPA'] as List<dynamic>),
      Backlogs: List<dynamic>.from(map['Backlogs'] as List<dynamic>),
      TotalSub: map['TotalSub'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Performance.fromJson(String source) =>
      Performance.fromMap(json.decode(source) as Map<String, dynamic>);
}
