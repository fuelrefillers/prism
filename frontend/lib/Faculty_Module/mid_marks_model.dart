import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MidMarksModel {
  String RollNo;
  int Marks;
  MidMarksModel({
    required this.RollNo,
    required this.Marks,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'RollNo': RollNo,
      'Marks': Marks,
    };
  }

  factory MidMarksModel.fromMap(Map<String, dynamic> map) {
    return MidMarksModel(
      RollNo: map['RollNo'] as String,
      Marks: map['Marks'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory MidMarksModel.fromJson(String source) =>
      MidMarksModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
