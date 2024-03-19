import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SubstitueModel {
  String Date;
  String Day;
  String StartTime;
  String EndTime;
  String Department;
  String Section;
  String Regulation;
  String Year;
  SubstitueModel({
    required this.Date,
    required this.Day,
    required this.StartTime,
    required this.EndTime,
    required this.Department,
    required this.Section,
    required this.Regulation,
    required this.Year,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Date': Date,
      'Day': Day,
      'StartTime': StartTime,
      'EndTime': EndTime,
      'Department': Department,
      'Section': Section,
      'Regulation': Regulation,
      'Year': Year,
    };
  }

  factory SubstitueModel.fromMap(Map<String, dynamic> map) {
    return SubstitueModel(
      Date: map['Date'] as String,
      Day: map['Day'] as String,
      StartTime: map['StartTime'] as String,
      EndTime: map['EndTime'] as String,
      Department: map['Department'] as String,
      Section: map['Section'] as String,
      Regulation: map['Regulation'] as String,
      Year: map['Year'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubstitueModel.fromJson(String source) =>
      SubstitueModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
