import 'package:flutter/material.dart';
import 'package:frontend/providers.dart/attendance_provider.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/widgets/attendance_guage.dart';
import 'package:frontend/widgets/linear_progress_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final Authservice authService = Authservice();

  @override
  void initState() {
    super.initState();
    // authService.getAttendance(context);
  }

  @override
  Widget build(BuildContext context) {
    final userAttendance = Provider.of<AttendanceProvider>(context).attendance;
    final formatter = DateFormat.yMMMEd();
    String formattedDate() {
      return formatter.format(DateTime.now());
    }

    Widget dayStatus = Center(
      child: Text(
        "Absent",
        style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 255, 0, 0)),
      ),
    );
    if (userAttendance.DayPresent == 1) {
      dayStatus = Center(
        child: Text(
          "Half Day Present",
          style:
              TextStyle(fontSize: 25, color: Color.fromARGB(255, 182, 100, 0)),
        ),
      );
    } else if (userAttendance.DayPresent == 2) {
      dayStatus = Center(
        child: Text(
          "Full Day Present",
          style:
              TextStyle(fontSize: 25, color: Color.fromARGB(255, 18, 182, 0)),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("This is your attendace summary"),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Total percentage ",
                      style: TextStyle(
                          fontSize: 25, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    Stack(
                      children: [
                        SizedBox(
                          child: Center(
                            child: AttendanceGuage(
                              totalAttendance:
                                  double.parse(userAttendance.SemPercentage) /
                                      100,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 14,
                            ),
                            SizedBox(
                              child: Center(
                                child: Text(
                                  "${userAttendance.SemPercentage}%",
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Monthly percentage ",
                        style: TextStyle(
                            fontSize: 25, color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      Text(
                        "${userAttendance.MonthlyPercentage}%",
                        style: TextStyle(
                            fontSize: 35, color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      LinearProgressBar(
                        progressPer:
                            double.parse(userAttendance.MonthlyPercentage) /
                                100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Date  ",
                            style: TextStyle(
                                fontSize: 35,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          Text(
                            formattedDate(),
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Day ",
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          dayStatus,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
