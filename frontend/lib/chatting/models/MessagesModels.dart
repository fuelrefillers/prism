// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageModel {
  String type;
  String message;
  String time;
  MessageModel({
    required this.type,
    required this.message,
    required this.time,
  });

  MessageModel copyWith({
    String? type,
    String? message,
    String? time,
  }) {
    return MessageModel(
      type: type ?? this.type,
      message: message ?? this.message,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'message': message,
      'time': time,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      type: map['type'] as String,
      message: map['message'] as String,
      time: map['time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MessageModel(type: $type, message: $message, time: $time)';

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.type == type && other.message == message && other.time == time;
  }

  @override
  int get hashCode => type.hashCode ^ message.hashCode ^ time.hashCode;
}
