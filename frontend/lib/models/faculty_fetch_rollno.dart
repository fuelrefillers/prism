import 'dart:convert';

class FacultyFetchRollNo {
  final String RollNo;
  final String StudentName;
  FacultyFetchRollNo({
    required this.RollNo,
    required this.StudentName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'RollNo': RollNo,
      'StudentName': StudentName,
    };
  }

  factory FacultyFetchRollNo.fromMap(Map<String, dynamic> map) {
    return FacultyFetchRollNo(
      RollNo: map['RollNo'] as String,
      StudentName: map['StudentName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FacultyFetchRollNo.fromJson(String source) =>
      FacultyFetchRollNo.fromMap(json.decode(source) as Map<String, dynamic>);
}
