import 'package:flutter/material.dart';
import 'package:frontend/models/timetable_model.dart';
import 'package:frontend/services/Students_Parents_services.dart';
import 'package:frontend/widgets/open_time_table.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen(
      {super.key, required this.department, required this.regulation});
  final String department;
  final String regulation;
  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  final StudentParentServices service = StudentParentServices();
  List<TimeTable> tt = [];
  bool isError = false;
  @override
  void initState() {
    super.initState();
    getCirculars();
  }

  void getCirculars() async {
    List<TimeTable> cir = await service.getTimetable(
        regulation: widget.regulation, department: widget.department);
    await Future.delayed(Duration(seconds: 1));
    print(cir);
    setState(() {
      tt = cir;
    });
    await Future.delayed(Duration(seconds: 5));
    if (cir.isEmpty) {
      setState(() {
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Table"),
      ),
      body: tt.isEmpty && isError == false
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : isError
              ? Center(
                  child: Text(
                      "Something went wrong or resultrs aren't updated yet !!!"),
                )
              : ListView.builder(
                  itemCount: tt.length,
                  itemBuilder: (context, index) => OpenTimeTable(
                      height1: 100, timetable: tt[index], context: context),
                ),
    );
  }
}
