import 'package:flutter/foundation.dart';
import 'dart:convert';
// import 'package:host/models/BoysFloors.dart'; // Import the BoysFloors model

import 'package:frontend/hostels/models/BoysFloors.dart';

class BoysFloorsProvider extends ChangeNotifier {
  BoysFloors _boysFloors = BoysFloors(
    floorNumber: 0,
    totalBeds: 0,
    availableBeds: 0,
  );

  BoysFloors get boysFloors => _boysFloors;

  void setBoysFloorsFromJSON(String floors) {
    _boysFloors = BoysFloors.fromJson(floors);
    notifyListeners();
  }

  void setBoysFloorsFromModel(BoysFloors floors) {
    _boysFloors = floors;
    notifyListeners();
  }

  String boysFloorsToJson() => jsonEncode(_boysFloors.toJson());
}
