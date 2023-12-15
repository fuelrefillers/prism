// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/main_screen.dart';
import 'package:frontend/providers.dart/faculty_provider.dart';
import 'package:frontend/widgets/multi_purpose_card.dart';
import 'package:provider/provider.dart';

class Students {
  final String rollno;
  final String name;
  final String section;
  Students({
    required this.rollno,
    required this.name,
    required this.section,
  });
}

class FacultyAttendanceScreen extends StatefulWidget {
  const FacultyAttendanceScreen({super.key});
  @override
  State<FacultyAttendanceScreen> createState() {
    return _FacultyAttendanceScreen();
  }
}

class _FacultyAttendanceScreen extends State<FacultyAttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    final faculty =
        Provider.of<FacultyProvider>(context, listen: false).faculty;
    return Scaffold(
      appBar: AppBar(
        title: Text("Select section"),
      ),
      body: ListView.builder(
        itemCount: faculty.Classes.length,
        itemBuilder: (context, index) => MultiPurposeCard(
            category: faculty.Classes[index],
            height1: 100,
            screen: MainScreen(section: faculty.Classes[index])),
      ),
    );
  }
}
