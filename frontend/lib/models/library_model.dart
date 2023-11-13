import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Library {
  final String rollno;
  final List<dynamic> booksTaken;
  final List<dynamic> dateTaken;
  Library({
    required this.rollno,
    required this.booksTaken,
    required this.dateTaken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rollno': rollno,
      'booksTaken': booksTaken,
      'dateTaken': dateTaken,
    };
  }

  factory Library.fromMap(Map<String, dynamic> map) {
    return Library(
      rollno: map['rollno'] as String,
      booksTaken: List<dynamic>.from((map['booksTaken'] as List<dynamic>)),
      dateTaken: List<dynamic>.from((map['dateTaken'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Library.fromJson(String source) =>
      Library.fromMap(json.decode(source) as Map<String, dynamic>);
}
