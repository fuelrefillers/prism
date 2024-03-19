import 'dart:convert';

//import 'package:flutter/foundation.dart';

class GirlsFloors {
  final int floorNumber;
  final int totalBeds;
  final int availableBeds;

  GirlsFloors({
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

  factory GirlsFloors.fromMap(Map<String, dynamic> map) {
    return GirlsFloors(
      floorNumber: map['floorNumber'] as int,
      totalBeds: map['totalBeds'] as int,
      availableBeds: map['availableBeds'] as int,
    );
  }

  String toJson() => json.encode(toMap());
  factory GirlsFloors.fromJson(String source) =>
      GirlsFloors.fromMap(json.decode(source) as Map<String, dynamic>);
}
