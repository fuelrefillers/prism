import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/extra_models.dart';
import 'package:frontend/services/ip.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timelines/timelines.dart';
import 'package:http/http.dart' as http;

class TotalAttendanceScreen extends StatefulWidget {
  const TotalAttendanceScreen({super.key});
  @override
  State<TotalAttendanceScreen> createState() => _TotalAttendanceScreenState();
}

class _TotalAttendanceScreenState extends State<TotalAttendanceScreen> {
  List<allAttendanceModel> data = [];
  bool isError = false;

  @override
  void initState() {
    super.initState();
    getAllatten();
  }

  void getAllatten() async {
    List<allAttendanceModel> temp = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');

    var response = await http.get(
      Uri.parse("${ip}/api/attendanceHistory/getAttendanceByHistories"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      print(result);
      for (int i = 0; i < result.length; i++) {
        allAttendanceModel post =
            allAttendanceModel.fromMap(result[i] as Map<String, dynamic>);
        temp.add(post);
      }

      temp.reversed.toList();

      setState(() {
        data = temp;
      });
    } else {
      setState(() {
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Day wise attendance"),
      ),
      body: isError
          ? Center(
              child: Text("Something went wrong"),
            )
          : data.isEmpty
              ? Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Timeline.tileBuilder(
                  builder: TimelineTileBuilder.fromStyle(
                    contentsAlign: ContentsAlign.alternating,
                    contentsBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                          '${data[index].date} - ${data[index].PresentStatus}'),
                    ),
                    itemCount: data.length,
                  ),
                ),
    );
  }
}
