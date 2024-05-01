import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/subjects_model.dart';
import 'package:frontend/screens/subjects_screens/individual_subjects_screen.dart';
import 'package:frontend/services/ip.dart';
import 'package:http/http.dart' as http;

class SubjectsHomeScreen extends StatefulWidget {
  final String regulation;
  final String department;
  final String section;
  final String rollno;
  const SubjectsHomeScreen(
      {super.key,
      required this.department,
      required this.regulation,
      required this.section,
      required this.rollno});

  @override
  State<SubjectsHomeScreen> createState() => _SubjectsHomeScreenState();
}

class _SubjectsHomeScreenState extends State<SubjectsHomeScreen> {
  List<SubjectsModel> subjects = [];
  bool isError = false;

  @override
  void initState() {
    super.initState();
    getSubjects();
  }

  void getSubjects() async {
    List<SubjectsModel> temp = [];
    var response = await http.get(Uri.parse(
        "${ip}/api/semesterdata/getSubjectsForClass?regulation=${widget.regulation}&department=${widget.department}&section=${widget.section}"));
    if (response.statusCode == 200) {
      print(response.body);

      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        SubjectsModel post =
            SubjectsModel.fromMap(result[i] as Map<String, dynamic>);
        temp.add(post);
      }

      setState(() {
        subjects = temp;
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
          title: Text("Subjects"),
        ),
        body: isError
            ? Center(
                child: Text("Something went wrong"),
              )
            : subjects.isEmpty
                ? Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : ListView.builder(
                    itemCount: subjects.length,
                    itemBuilder: (context, index) => ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        IndividualSubjectsScreen(
                                            subjectCode:
                                                subjects[index].SubjectCode,
                                            title: subjects[index].SubjectName,
                                            rollno: widget.rollno)));
                          },
                          leading: Icon(
                            Icons.book,
                            size: 40,
                          ),
                          title: Text(
                            subjects[index].SubjectName,
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(subjects[index].LecturerName),
                        )));
  }
}
