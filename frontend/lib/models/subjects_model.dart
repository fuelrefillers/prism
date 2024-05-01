import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SubjectsModel {
  final String SubjectName;
  final String SubjectCode;
  final String LecturerId;
  final String LecturerName;
  SubjectsModel({
    required this.SubjectName,
    required this.SubjectCode,
    required this.LecturerId,
    required this.LecturerName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'SubjectName': SubjectName,
      'SubjectCode': SubjectCode,
      'LecturerId': LecturerId,
      'LecturerName': LecturerName,
    };
  }

  factory SubjectsModel.fromMap(Map<String, dynamic> map) {
    return SubjectsModel(
      SubjectName: map['SubjectName'] as String,
      SubjectCode: map['SubjectCode'] as String,
      LecturerId: map['LecturerId'] as String,
      LecturerName: map['LecturerName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectsModel.fromJson(String source) =>
      SubjectsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
