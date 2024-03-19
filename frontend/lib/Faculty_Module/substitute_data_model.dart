import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SubstituteModelFORDROP {
  String FacultyId;
  String FacultyName;
  SubstituteModelFORDROP({
    required this.FacultyId,
    required this.FacultyName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'FacultyId': FacultyId,
      'FacultyName': FacultyName,
    };
  }

  factory SubstituteModelFORDROP.fromMap(Map<String, dynamic> map) {
    return SubstituteModelFORDROP(
      FacultyId: map['FacultyId'] as String,
      FacultyName: map['FacultyName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubstituteModelFORDROP.fromJson(String source) =>
      SubstituteModelFORDROP.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
