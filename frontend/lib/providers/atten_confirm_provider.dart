import 'package:flutter/material.dart';
import 'package:frontend/models/att_confirmation_model.dart';

class AttendanceConfirm extends ChangeNotifier {
  AttenConfirm _attenConfirm = AttenConfirm(attendees: 0, absentees: []);

  AttenConfirm get attenConfirm => _attenConfirm;

  void setAttenFromJsonString(String atten) {
    _attenConfirm = AttenConfirm.fromJson(atten);
    notifyListeners();
  }

  void setAttenFromModel(AttenConfirm atten) {
    _attenConfirm = atten;
  }
}
