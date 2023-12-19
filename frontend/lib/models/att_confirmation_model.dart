import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AttenConfirm {
  final int attendees;
  final List<dynamic> absentees;
  AttenConfirm({
    required this.attendees,
    required this.absentees,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'attendees': attendees,
      'absentees': absentees,
    };
  }

  factory AttenConfirm.fromMap(Map<String, dynamic> map) {
    return AttenConfirm(
      attendees: map['attendees'] as int,
      absentees: List<dynamic>.from(map['absentees'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory AttenConfirm.fromJson(String source) =>
      AttenConfirm.fromMap(json.decode(source) as Map<String, dynamic>);
}

// success: true, message: 'Attendance updated successfully',attendees:filteredListARRANGED.length,absentees:rollNumbers