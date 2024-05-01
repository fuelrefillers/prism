import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/extra_models.dart';
import 'package:frontend/services/ip.dart';
import 'package:http/http.dart' as http;
import 'package:timelines/timelines.dart';

class SubjectAttendance extends StatefulWidget {
  final String rollno;
  final String subjectcode;
  const SubjectAttendance(
      {super.key, required this.rollno, required this.subjectcode});

  @override
  State<SubjectAttendance> createState() => _SubjectAttendanceState();
}

class _SubjectAttendanceState extends State<SubjectAttendance> {
  List<SubjectAttendanceModel> data = [];
  bool isError = false;

  @override
  void initState() {
    super.initState();
    getSubjectAttendance();
  }

  void getSubjectAttendance() async {
    List<SubjectAttendanceModel> temp = [];
    var response = await http.get(Uri.parse(
        "${ip}/api/attendanceHistory/getSubjectWiseAttendance?rollno=${widget.rollno}&subjectcode=${widget.subjectcode}"));
    if (response.statusCode == 200) {
      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        SubjectAttendanceModel post =
            SubjectAttendanceModel.fromMap(result[i] as Map<String, dynamic>);
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
        title: Text("Sbject Attendance"),
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
                          '${data[index].date} - ${data[index].startTime} - ${data[index].endTime} - ${data[index].present == true ? "Present" : "Abscent"}'),
                    ),
                    itemCount: data.length,
                  ),
                ),
    );
  }
}
