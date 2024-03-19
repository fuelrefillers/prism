// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GirlsRooms {
  int floorNumber;
  int roomNumber;
  List<int> bedNumber;
  List<dynamic> bookedBy;
  List<String> status;
  List<String> adminId;
  GirlsRooms({
    required this.floorNumber,
    required this.roomNumber,
    required this.bedNumber,
    required this.bookedBy,
    required this.status,
    required this.adminId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'floorNumber': floorNumber,
      'roomNumber': roomNumber,
      'bedNumber': bedNumber,
      'bookedBy': bookedBy,
      'status': status,
      'adminId': adminId,
    };
  }

  factory GirlsRooms.fromMap(Map<String, dynamic> map) {
    return GirlsRooms(
      floorNumber: map['floorNumber'] as int,
      roomNumber: map['roomNumber'] as int,
      bedNumber: List<int>.from((map['bedNumber'] as List<int>)),
      bookedBy: List<dynamic>.from((map['bookedBy'] as List<dynamic>)),
      status: List<String>.from((map['status'] as List<String>)),
      adminId: List<String>.from((map['adminId'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory GirlsRooms.fromJson(String source) =>
      GirlsRooms.fromMap(json.decode(source) as Map<String, dynamic>);
}
