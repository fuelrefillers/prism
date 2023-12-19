import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Library {
  final String RollNo;
  final List<dynamic> booksTaken;
  final List<dynamic> dateTaken;
  Library({
    required this.RollNo,
    required this.booksTaken,
    required this.dateTaken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'RollNo': RollNo,
      'booksTaken': booksTaken,
      'dateTaken': dateTaken,
    };
  }

  factory Library.fromMap(Map<String, dynamic> map) {
    return Library(
      RollNo: map['RollNo'] as String,
      booksTaken: List<dynamic>.from((map['booksTaken'] as List<dynamic>)),
      dateTaken: List<dynamic>.from((map['dateTaken'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Library.fromJson(String source) =>
      Library.fromMap(json.decode(source) as Map<String, dynamic>);
}
