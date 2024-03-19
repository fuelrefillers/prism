import 'dart:convert';
import 'package:frontend/services/ip.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/review_update.dart';
import 'package:frontend/models/faculty_fetch_rollno.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen(
      {super.key,
      required this.department,
      required this.section,
      required this.regulation,
      required this.startTime,
      required this.endTime,
      required this.selectedDate});
  final String section;
  final String department;
  final String regulation;
  final String startTime;
  final String endTime;
  final DateTime selectedDate;
  @override
  State<MainScreen> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  List<FacultyFetchRollNo> data = [];
  List<String> selected = [];

  @override
  void initState() {
    super.initState();
    getRollno();
  }

  void onRollnoSelected(bool? value, rollno) {
    if (value == true) {
      setState(() {
        selected.add(rollno);
      });
    } else {
      setState(() {
        selected.remove(rollno);
      });
    }
  }

  void getRollno() async {
    List<FacultyFetchRollNo> res = [];
    try {
      var response = await http.get(Uri.parse(
          '${ip}/api/userdata/filter?section=${widget.section}&department=${widget.department}&regulation=${widget.regulation}'));
      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        FacultyFetchRollNo post =
            FacultyFetchRollNo.fromMap(result[i] as Map<String, dynamic>);
        res.add(post);
      }
      print("object");
      setState(() {
        res.sort((a, b) => a.RollNo.compareTo(b.RollNo));
        data = res;
      });
      print(res[0]);
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.department}-${widget.section}"),
      ),
      body: Column(
        children: [
          Container(
            child: Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => CheckboxListTile(
                  value: selected.contains(data[index].RollNo),
                  onChanged: (bool? value) {
                    onRollnoSelected(value, data[index].RollNo);
                  },
                  title: Text(data[index].RollNo.toUpperCase()),
                  subtitle: Text(data[index].StudentName),
                ),
              ),
            ),
          ),
          // Container(
          //   child: Expanded(
          //     child: ListView.builder(
          //         itemCount: selected.length,
          //         itemBuilder: (context, index) => ElevatedButton(
          //             onPressed: () {}, child: Text(selected[index]))),
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (DateFormat('yyyy-MM-dd').format(DateTime.now()) ==
              DateFormat('yyyy-MM-dd').format(widget.selectedDate)) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ReviewAndSubmitScreen(
                    selected: selected,
                    section: widget.section,
                    department: widget.department,
                    regulation: widget.regulation,
                    startTime: widget.startTime,
                    endTime: widget.endTime),
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("Warning"),
                content: const Text(
                    "Date does not match you cannot mark attendance !"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("cancel"),
                  ),
                ],
              ),
            );
          }
        },
        label: const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Text("Next"),
        ),
        enableFeedback: true,
      ),
    );
  }
}
