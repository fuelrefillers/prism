// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Books {
  final String id;
  final String Department;
  final String Regulation;
  final String BookName;
  final String BookImageUrl;
  final String BookLinkUrl;
  final String BookAuthor;
  Books({
    required this.id,
    required this.Department,
    required this.Regulation,
    required this.BookName,
    required this.BookImageUrl,
    required this.BookLinkUrl,
    required this.BookAuthor,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'Department': Department,
      'Regulation': Regulation,
      'BookName': BookName,
      'BookImageUrl': BookImageUrl,
      'BookLinkUrl': BookLinkUrl,
      'BookAuthor': BookAuthor,
    };
  }

  factory Books.fromMap(Map<String, dynamic> map) {
    return Books(
      id: map['id'] as String,
      Department: map['Department'] as String,
      Regulation: map['Regulation'] as String,
      BookName: map['BookName'] as String,
      BookImageUrl: map['BookImageUrl'] as String,
      BookLinkUrl: map['BookLinkUrl'] as String,
      BookAuthor: map['BookAuthor'] as String,
    );
  }

  // Save a list of models to SharedPreferences
  static Future<void> saveListToLocalStorage(
      List<Books> list, String key) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = list.map((book) => book.toMap()).toList();
    prefs.setString(key, jsonEncode(encodedList));
  }

  // Load a list of models from SharedPreferences
  static Future<List<Books>> loadListFromLocalStorage(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      final decodedList = jsonDecode(jsonString) as List<dynamic>;
      return decodedList.map((map) => Books.fromMap(map)).toList();
    }
    return [];
  }

  String toJson() => json.encode(toMap());

  factory Books.fromJson(String source) =>
      Books.fromMap(json.decode(source) as Map<String, dynamic>);
}
