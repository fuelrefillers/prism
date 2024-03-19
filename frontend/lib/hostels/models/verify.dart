// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Verify {
  final String adminId;
  final String userName;
  final String status;

  Verify({required this.adminId, required this.userName, required this.status});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adminId': adminId,
      'userName': userName,
      'status': status,
    };
  }

  factory Verify.fromMap(Map<String, dynamic> map) {
    return Verify(
      adminId: map['adminId'] as String,
      userName: map['userName'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Verify.fromJson(String source) =>
      Verify.fromMap(json.decode(source) as Map<String, dynamic>);
}
