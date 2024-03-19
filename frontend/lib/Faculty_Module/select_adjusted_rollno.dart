import 'dart:convert';
import 'package:frontend/models/adjust_model.dart';
import 'package:frontend/services/ip.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AdjustSelectedScreen extends StatefulWidget {
  const AdjustSelectedScreen(
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
  State<AdjustSelectedScreen> createState() {
    return _AdjustSelectedScreenState();
  }
}

class _AdjustSelectedScreenState extends State<AdjustSelectedScreen> {
  List<Adjust> data = [];
  bool updateConfirmed = false;
  bool inprogress = false;
  bool failed = false;
  @override
  void initState() {
    super.initState();
    getRollno();
  }

  void getRollno() async {
    List<Adjust> res = [];
    try {
      var response = await http.post(
        Uri.parse(
            '${ip}/api/attendance/getAdjustRno?section=${widget.section}&department=${widget.department}&regulation=${widget.regulation}'),
        body: jsonEncode({
          "selectedDate": DateFormat('yyyy-MM-dd').format(widget.selectedDate),
          "startTime": widget.startTime,
          "endTime": widget.endTime
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        Adjust post = Adjust.fromMap(result[i] as Map<String, dynamic>);
        res.add(post);
      }
      setState(() {
        res.sort((a, b) => a.RollNo.compareTo(b.RollNo));
        data = res;
      });
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
                itemBuilder: (context, index) => ListTile(
                  shape: Border.all(),
                  tileColor: data[index].Present
                      ? Color.fromARGB(255, 34, 140, 43) // Green color
                      : Color.fromARGB(255, 159, 16, 16), // Red color
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text("Confirmation"),
                        content: Text(
                          data[index].Present
                              ? "Do you want to mark present student ${data[index].RollNo.toUpperCase()} as absent?"
                              : "Do you want to mark absent student ${data[index].RollNo.toUpperCase()} as present?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () async {
                              var response = await http.post(
                                Uri.parse(
                                    '${ip}/api/attendance/setAdjustRno?rollNo=${data[index].RollNo.toUpperCase()}'),
                                body: jsonEncode({
                                  "selectedDate": DateFormat('yyyy-MM-dd')
                                      .format(widget.selectedDate),
                                  "startTime": widget.startTime,
                                  "endTime": widget.endTime,
                                }),
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                },
                              );

                              if (response.statusCode == 200) {
                                setState(() {
                                  // Toggle the Present value
                                  data[index].Present = !data[index].Present;
                                });
                              }

                              Navigator.pop(
                                  context); // Dismiss the dialog after action
                            },
                            child: Text("Okay"),
                          ),
                        ],
                      ),
                    );
                  },
                  title: Text(data[index].RollNo.toUpperCase()),
                  subtitle: Text(data[index].Present.toString()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
