import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Adjust {
  final String RollNo;
  bool Present;
  Adjust({
    required this.RollNo,
    required this.Present,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'RollNo': RollNo,
      'Present': Present,
    };
  }

  factory Adjust.fromMap(Map<String, dynamic> map) {
    return Adjust(
      RollNo: map['RollNo'] as String,
      Present: map['Present'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Adjust.fromJson(String source) =>
      Adjust.fromMap(json.decode(source) as Map<String, dynamic>);
}
