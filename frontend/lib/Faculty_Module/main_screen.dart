import 'dart:convert';
import 'package:frontend/services/ip.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/review_update.dart';
import 'package:frontend/models/faculty_fetch_rollno.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.section});
  final String section;
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
          '${ip}/api/userdata/filter?section=${widget.section[widget.section.length - 1]}&department=${widget.section.substring(0, widget.section.length - 2)}'));
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
        title: Text(
            "${widget.section.substring(0, widget.section.length - 2)}-${widget.section[widget.section.length - 1]}"),
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
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ReviewAndSubmitScreen(
                    selected: selected,
                    section: widget.section[widget.section.length - 1],
                    department:
                        widget.section.substring(0, widget.section.length - 2),
                  )));
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
