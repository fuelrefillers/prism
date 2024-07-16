// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';

class Add_Category {
  final String name;
  final Uint8List img;

  Add_Category({required this.name, required this.img});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'img': img,
    };
  }

  factory Add_Category.fromMap(Map<String, dynamic> map) {
    return Add_Category(
      name: map['name'] as String,
      img: map['img'] as Uint8List,
    );
  }
  // Save a list of models to SharedPreferences
  static Future<void> saveListToLocalStorage(
      List<Add_Category> list, String key) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = list.map((x) => x.toMap()).toList();
    prefs.setString(key, jsonEncode(encodedList));
  }

  // Load a list of models from SharedPreferences
  static Future<List<Add_Category>> loadListFromLocalStorage(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      final decodedList = jsonDecode(jsonString) as List<dynamic>;
      return decodedList.map((map) => Add_Category.fromMap(map)).toList();
    }
    return [];
  }

  // Delete a book with a specific ID from SharedPreferences
  static Future<void> deleteBookFromLocalStorage(String key, String id) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      final decodedList = jsonDecode(jsonString) as List<dynamic>;
      final updatedList = decodedList.where((map) => map['id'] != id).toList();
      prefs.setString(key, jsonEncode(updatedList));
    }
  }

  String toJson() => json.encode(toMap());

  factory Add_Category.fromJson(String source) =>
      Add_Category.fromMap(json.decode(source) as Map<String, dynamic>);
}