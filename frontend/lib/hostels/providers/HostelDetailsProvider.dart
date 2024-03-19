import 'package:flutter/material.dart';
// import 'package:host/models/HostelDetails.dart';
import 'package:frontend/hostels/models/HostelDetails.dart';

import 'dart:convert';

class HostelDetailsProvider extends ChangeNotifier {
  HostelDetails _hostelDetails = HostelDetails(
    hostelId: 0,
    hostelType: '',
    floors: 0,
    totalRooms: 0,
    specialRooms: 0,
    beds: 0,
  );

  HostelDetails get hostelDetails => _hostelDetails;

  void setHostelDetails(String hostelDetails) {
    final Map<String, dynamic> jsonMap = json.decode(hostelDetails);
    _hostelDetails = HostelDetails.fromJson(jsonMap);
    notifyListeners();
  }

  void setHostelDetailsFromModel(HostelDetails details) {
    _hostelDetails = details;
    notifyListeners();
  }
}
