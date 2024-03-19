import 'package:flutter/foundation.dart';
import 'dart:convert';
// import 'package:host/models/GirlsFloors.dart';

import 'package:frontend/hostels/models/GirlsFloors.dart';

class GirlsFloorsProvider extends ChangeNotifier {
  GirlsFloors _girlsFloors = GirlsFloors(
    floorNumber: 0,
    totalBeds: 0,
    availableBeds: 0,
  );

  GirlsFloors get girlsFloors => _girlsFloors;

  void setGirlsFloorsFromJSON(String floors) {
    _girlsFloors = GirlsFloors.fromJson(floors);
    notifyListeners();
  }

  void setGirlsFloorsFromModel(GirlsFloors floors) {
    _girlsFloors = floors;
    notifyListeners();
  }

  String girlsFloorsToJson() => jsonEncode(_girlsFloors.toJson());
}
