import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatModel {
  String Id;
  String Name;
  String Department;
  String optional;
  ChatModel({
    required this.Id,
    required this.Name,
    required this.Department,
    required this.optional,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'Name': Name,
      'Department': Department,
      'optional': optional,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      Id: map['Id'] as String,
      Name: map['Name'] as String,
      Department: map['Department'] as String,
      optional: map['optional'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static Future<List<ChatModel>> getAllFromStorage(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(type);
    if (jsonString != null) {
      List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((e) => ChatModel.fromMap(e)).toList();
    }
    return [];
  }

  static Future<void> saveAllToStorage(
      List<ChatModel> allContacts, String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> jsonList =
        allContacts.map((e) => e.toMap()).toList();
    String jsonString = json.encode(jsonList);
    await prefs.setString(type, jsonString);
  }

  static Future<bool> isChatModelPresent(ChatModel model, String type) async {
    List<ChatModel> allContacts = await getAllFromStorage(type);
    return allContacts.any((element) => element.Id == model.Id);
  }
}
