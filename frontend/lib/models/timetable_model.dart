import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TimeTable {
  final String TimeTableTitle;
  final String Department;
  final String Regulation;
  final String TimeTableUrl;
  final String id;
  TimeTable({
    required this.TimeTableTitle,
    required this.Department,
    required this.Regulation,
    required this.TimeTableUrl,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'TimeTableTitle': TimeTableTitle,
      'Department': Department,
      'Regulation': Regulation,
      'TimeTableUrl': TimeTableUrl,
      'id': id,
    };
  }

  factory TimeTable.fromMap(Map<String, dynamic> map) {
    return TimeTable(
      TimeTableTitle: map['TimeTableTitle'] as String,
      Department: map['Department'] as String,
      Regulation: map['Regulation'] as String,
      TimeTableUrl: map['TimeTableUrl'] as String,
      id: map['id'] as String,
    );
  }

  static Future<void> saveListToLocalStorage(
      List<TimeTable> list, String key) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = list.map((circular) => circular.toMap()).toList();
    prefs.setString(key, jsonEncode(encodedList));
  }

  // Load a list of models from SharedPreferences
  static Future<List<TimeTable>> loadListFromLocalStorage(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      final decodedList = jsonDecode(jsonString) as List<dynamic>;
      return decodedList.map((map) => TimeTable.fromMap(map)).toList();
    }
    return [];
  }

  String toJson() => json.encode(toMap());

  factory TimeTable.fromJson(String source) =>
      TimeTable.fromMap(json.decode(source) as Map<String, dynamic>);
}
