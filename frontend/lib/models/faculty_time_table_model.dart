import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FacultyTimeTable {
  final String FacultyId;
  final String FacultyName;
  final String FacultyDepartment;
  final List<FTimeTable> TimeTable;
  FacultyTimeTable({
    required this.FacultyId,
    required this.FacultyName,
    required this.FacultyDepartment,
    required this.TimeTable,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'FacultyId': FacultyId,
      'FacultyName': FacultyName,
      'FacultyDepartment': FacultyDepartment,
      'TimeTable': TimeTable.map((x) => x.toMap()).toList(),
    };
  }

  factory FacultyTimeTable.fromMap(Map<String, dynamic> map) {
    return FacultyTimeTable(
      FacultyId: map['FacultyId'] as String,
      FacultyName: map['FacultyName'] as String,
      FacultyDepartment: map['FacultyDepartment'] as String,
      TimeTable: List<FTimeTable>.from(
        (map['TimeTable'] as List<int>).map<FTimeTable>(
          (x) => FTimeTable.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FacultyTimeTable.fromJson(String source) =>
      FacultyTimeTable.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FTimeTable {
  final String Day;
  final List<FPeriods> Periods;
  FTimeTable({
    required this.Day,
    required this.Periods,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Day': Day,
      'Periods': Periods.map((x) => x.toMap()).toList(),
    };
  }

  factory FTimeTable.fromMap(Map<String, dynamic> map) {
    return FTimeTable(
      Day: map['Day'] as String,
      Periods: List<FPeriods>.from(
        (map['Periods'] as List<int>).map<FPeriods>(
          (x) => FPeriods.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FTimeTable.fromJson(String source) =>
      FTimeTable.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FPeriods {
  final String StartTime;
  final String EndTime;
  final String ClassType;
  final String Section;
  final String Department;
  final String Year;
  final String Regulation;
  final String SubjectName;
  final String Subjectcode;
  FPeriods({
    required this.StartTime,
    required this.EndTime,
    required this.ClassType,
    required this.Section,
    required this.Department,
    required this.Year,
    required this.Regulation,
    required this.SubjectName,
    required this.Subjectcode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'StartTime': StartTime,
      'EndTime': EndTime,
      'ClassType': ClassType,
      'Section': Section,
      'Department': Department,
      'Year': Year,
      'Regulation': Regulation,
      'SubjectName': SubjectName,
      'Subjectcode': Subjectcode,
    };
  }

  factory FPeriods.fromMap(Map<String, dynamic> map) {
    return FPeriods(
      StartTime: map['StartTime'] as String,
      EndTime: map['EndTime'] as String,
      ClassType: map['ClassType'] as String,
      Section: map['Section'] as String,
      Department: map['Department'] as String,
      Year: map['Year'] as String,
      Regulation: map['Regulation'] as String,
      SubjectName: map['SubjectName'] as String,
      Subjectcode: map['Subjectcode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FPeriods.fromJson(String source) =>
      FPeriods.fromMap(json.decode(source) as Map<String, dynamic>);
}
