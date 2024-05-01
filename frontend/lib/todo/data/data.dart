import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMMMEd();
const uuid = Uuid();

class TodoList {
  final String id;
  final String title;
  final String time;
  final DateTime date;
  TodoList({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
  });

  String get formattedDate {
    return formatter.format(date);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'time': time,
    };
  }

  factory TodoList.fromJson(Map<String, dynamic> json) {
    return TodoList(
      id: json['id'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      time: json['time'],
    );
  }
}

class TodoService {
  static const _key = 'todoList';

  static Future<void> saveTodoList(List<TodoList> todoList) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStringList = todoList.map((todo) => todo.toJson()).toList();
    await prefs.setStringList(
        _key, jsonStringList.map((e) => jsonEncode(e)).toList());
  }

  static Future<List<TodoList>> loadTodoList() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStringList = prefs.getStringList(_key) ?? [];
    return jsonStringList
        .map((jsonString) => TodoList.fromJson(jsonDecode(jsonString)))
        .toList();
  }

  static Future<void> deleteTodoList() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
