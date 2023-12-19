import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CircularsModel {
  final String circularTitle;
  final String Department;
  final String Regulation;
  final String CircularUrl;
  final String id;
  CircularsModel({
    required this.circularTitle,
    required this.Department,
    required this.Regulation,
    required this.CircularUrl,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'circularTitle': circularTitle,
      'Department': Department,
      'Regulation': Regulation,
      'CircularUrl': CircularUrl,
      'id': id,
    };
  }

  factory CircularsModel.fromMap(Map<String, dynamic> map) {
    return CircularsModel(
      circularTitle: map['circularTitle'] as String,
      Department: map['Department'] as String,
      Regulation: map['Regulation'] as String,
      CircularUrl: map['CircularUrl'] as String,
      id: map['id'] as String,
    );
  }

  static Future<void> saveListToLocalStorage(
      List<CircularsModel> list, String key) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = list.map((circular) => circular.toMap()).toList();
    prefs.setString(key, jsonEncode(encodedList));
  }

  // Load a list of models from SharedPreferences
  static Future<List<CircularsModel>> loadListFromLocalStorage(
      String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      final decodedList = jsonDecode(jsonString) as List<dynamic>;
      return decodedList.map((map) => CircularsModel.fromMap(map)).toList();
    }
    return [];
  }

  String toJson() => json.encode(toMap());

  factory CircularsModel.fromJson(String source) =>
      CircularsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
