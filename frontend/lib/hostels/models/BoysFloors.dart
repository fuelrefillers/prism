import 'dart:convert';

//import 'package:flutter/foundation.dart';

class BoysFloors {
  final int floorNumber;
  final int totalBeds;
  final int availableBeds;

  BoysFloors({
    required this.floorNumber,
    required this.totalBeds,
    required this.availableBeds,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'floorNumber': floorNumber,
      'totalBeds': totalBeds,
      'availableBeds': availableBeds,
    };
  }

  factory BoysFloors.fromMap(Map<String, dynamic> map) {
    return BoysFloors(
      floorNumber: map['floorNumber'] as int,
      totalBeds: map['totalBeds'] as int,
      availableBeds: map['availableBeds'] as int,
    );
  }

  String toJson() => json.encode(toMap());
  factory BoysFloors.fromJson(String source) =>
      BoysFloors.fromMap(json.decode(source) as Map<String, dynamic>);
}

// BoysFloors BoysFloorsFromJson(String str) =>
//     BoysFloors.fromJson(json.decode(str));

// String BoysFloorsToJson(BoysFloors data) => json.encode(data.toJson());

// class BoysFloors {
//   final int floorNumber;
//   int totalBeds;
//   int availableBeds;

//   BoysFloors({
//     required this.floorNumber,
//     required this.totalBeds,
//     required this.availableBeds,
//   });

//   factory BoysFloors.fromJson(Map<String, dynamic> json) => BoysFloors(
//         floorNumber: json["floorNumber"],
//         totalBeds: json["totalBeds"],
//         availableBeds: json["availableBeds"],
//       );

//   Map<String, dynamic> toJson() => {
//         "floorNumber": floorNumber,
//         "totalBeds": totalBeds,
//         "availableBeds": availableBeds,
//       };
// }
