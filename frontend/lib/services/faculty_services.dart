import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/faculty-home-screen.dart';
import 'package:frontend/providers.dart/atten_confirm_provider.dart';
import 'package:frontend/providers.dart/is_error_provider.dart';
import 'package:frontend/providers.dart/is_loading_provider.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/services/ip.dart';
import 'package:provider/provider.dart';

class FacultyServices {
// Faculty to set attendance
  void setAttendance(
      {required List<String> rollnumbers,
      required String section,
      required String department,
      required BuildContext context}) async {
    try {
      final attenProvider =
          Provider.of<AttendanceConfirm>(context, listen: false);
      final loaging = Provider.of<isLoadinProvider>(context, listen: false);
      final Err = Provider.of<isErrorProvider>(context, listen: false);
      http.Response res = await http.post(
        Uri.parse(
            '${ip}/api/attendance/setAttendance?section=${section}&department=${department}'),
        body: jsonEncode({
          'rollNumbers': rollnumbers,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        await Future.delayed(Duration(seconds: 1));
        if (loaging.isloading == true) {
          loaging.changeStatus();
        }
        attenProvider.setAttenFromJsonString(res.body);
      } else if (res.statusCode != 200) {
        if (loaging.isloading == true) {
          loaging.changeStatus();
        }
        if (Err.isError == false) {
          Err.changeStatus();
        }
      }
    } catch (err) {
      print(err);
    }
  }
  // setAttendance function ends here
}
