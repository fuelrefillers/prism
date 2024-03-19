import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PrevQp {
  final String Id;
  final String SubjectName;
  final String Department;
  final String Regulation;
  final String PrevQuestionPaperAddress;
  final String PrevQuestionPaperUrl;

  PrevQp({
    required this.Id,
    required this.SubjectName,
    required this.Department,
    required this.Regulation,
    required this.PrevQuestionPaperAddress,
    required this.PrevQuestionPaperUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'SubjectName': SubjectName,
      'Department': Department,
      'Regulation': Regulation,
      'PrevQuestionPaperAddress': PrevQuestionPaperAddress,
      'PrevQuestionPaperUrl': PrevQuestionPaperUrl,
    };
  }

  factory PrevQp.fromMap(Map<String, dynamic> map) {
    return PrevQp(
      Id: map['Id'] as String,
      SubjectName: map['SubjectName'] as String,
      Department: map['Department'] as String,
      Regulation: map['Regulation'] as String,
      PrevQuestionPaperAddress: map['PrevQuestionPaperAddress'] as String,
      PrevQuestionPaperUrl: map['PrevQuestionPaperUrl'] as String,
    );
  }

  // Save a list of models to SharedPreferences
  static Future<void> saveListToLocalStorage(
      List<PrevQp> list, String key) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = list.map((prevQp) => prevQp.toMap()).toList();
    prefs.setString(key, jsonEncode(encodedList));
  }

  // Load a list of models from SharedPreferences
  static Future<List<PrevQp>> loadListFromLocalStorage(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      final decodedList = jsonDecode(jsonString) as List<dynamic>;
      return decodedList.map((map) => PrevQp.fromMap(map)).toList();
    }
    return [];
  }

  static Future<void> deleteItemFromLocalStorage(String key, String id) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);

    if (jsonString != null) {
      final decodedList = jsonDecode(jsonString) as List<dynamic>;
      List<PrevQp> prevQpList =
          decodedList.map((map) => PrevQp.fromMap(map)).toList();

      prevQpList.removeWhere((prevQp) => prevQp.Id == id);

      // Save the updated list back to SharedPreferences
      final encodedList = prevQpList.map((prevQp) => prevQp.toMap()).toList();
      prefs.setString(key, jsonEncode(encodedList));
    }
  }

  String toJson() => json.encode(toMap());

  factory PrevQp.fromJson(String source) =>
      PrevQp.fromMap(json.decode(source) as Map<String, dynamic>);
}
