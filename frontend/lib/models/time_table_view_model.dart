// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TimeTableForStudents {
  final String Regulation;
  final String Department;
  final String Section;
  final List<TimeTableView> TimeTable;
  TimeTableForStudents({
    required this.Regulation,
    required this.Department,
    required this.Section,
    required this.TimeTable,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Regulation': Regulation,
      'Department': Department,
      'Section': Section,
      'TimeTable': TimeTable.map((x) => x.toMap()).toList(),
    };
  }

  factory TimeTableForStudents.fromMap(Map<String, dynamic> map) {
    return TimeTableForStudents(
      Regulation: map['Regulation'] as String,
      Department: map['Department'] as String,
      Section: map['Section'] as String,
      TimeTable: List<TimeTableView>.from(
        (map['TimeTable'] as List<int>).map<TimeTableView>(
          (x) => TimeTableView.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeTableForStudents.fromJson(String source) =>
      TimeTableForStudents.fromMap(json.decode(source) as Map<String, dynamic>);
}

class TimeTableView {
  final String Day;
  final List<Period> Periods;
  TimeTableView({
    required this.Day,
    required this.Periods,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Day': Day,
      'Periods': Periods.map((x) => x.toMap()).toList(),
    };
  }

  factory TimeTableView.fromMap(Map<String, dynamic> map) {
    return TimeTableView(
      Day: map['Day'] as String,
      Periods: List<Period>.from(
        (map['Periods'] as List<int>).map<Period>(
          (x) => Period.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeTableView.fromJson(String source) =>
      TimeTableView.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Period {
  final String id;
  final String startTime;
  final String endTime;
  final String classType;
  final String className;
  final String subjectName;
  final String subjectCode;
  final String lecturerName;
  final String lecturerId;
  final String lecturerNumber;
  final bool substitute;

  Period({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.classType,
    required this.className,
    required this.subjectName,
    required this.subjectCode,
    required this.lecturerName,
    required this.lecturerId,
    required this.lecturerNumber,
    required this.substitute,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'startTime': startTime,
      'endTime': endTime,
      'classType': classType,
      'className': className,
      'subjectName': subjectName,
      'subjectCode': subjectCode,
      'lecturerName': lecturerName,
      'lecturerId': lecturerId,
      'lecturerNumber': lecturerNumber,
      'substitute': substitute,
    };
  }

  factory Period.fromMap(Map<String, dynamic> map) {
    return Period(
      id: map['id'] as String,
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
      classType: map['classType'] as String,
      className: map['className'] as String,
      subjectName: map['subjectName'] as String,
      subjectCode: map['subjectCode'] as String,
      lecturerName: map['lecturerName'] as String,
      lecturerId: map['lecturerId'] as String,
      lecturerNumber: map['lecturerNumber'] as String,
      substitute: map['substitute'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Period.fromJson(String source) =>
      Period.fromMap(json.decode(source) as Map<String, dynamic>);
}
