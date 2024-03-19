import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MidDetails {
  String Regulation;
  String Department;
  String Section;
  String SubjectName;
  String SubjectCode;
  String LecturerId;
  String Mid;
  MidDetails({
    required this.Regulation,
    required this.Department,
    required this.Section,
    required this.SubjectName,
    required this.SubjectCode,
    required this.LecturerId,
    required this.Mid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Regulation': Regulation,
      'Department': Department,
      'Section': Section,
      'SubjectName': SubjectName,
      'SubjectCode': SubjectCode,
      'LecturerId': LecturerId,
      'Mid': Mid,
    };
  }

  factory MidDetails.fromMap(Map<String, dynamic> map) {
    return MidDetails(
      Regulation: map['Regulation'] as String,
      Department: map['Department'] as String,
      Section: map['Section'] as String,
      SubjectName: map['SubjectName'] as String,
      SubjectCode: map['SubjectCode'] as String,
      LecturerId: map['LecturerId'] as String,
      Mid: map['Mid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MidDetails.fromJson(String source) =>
      MidDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}
