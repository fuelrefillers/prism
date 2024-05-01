import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ClassesModel {
  String Department;
  String Section;
  String Regulation;
  String Year;
  // String Subject;
  // String SubjectCode;
  ClassesModel({
    required this.Department,
    required this.Section,
    required this.Regulation,
    required this.Year,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Department': Department,
      'Section': Section,
      'Regulation': Regulation,
      'Year': Year,
    };
  }

  factory ClassesModel.fromMap(Map<String, dynamic> map) {
    return ClassesModel(
      Department: map['Department'] as String,
      Section: map['Section'] as String,
      Regulation: map['Regulation'] as String,
      Year: map['Year'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassesModel.fromJson(String source) =>
      ClassesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
