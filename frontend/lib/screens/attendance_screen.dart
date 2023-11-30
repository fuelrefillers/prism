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

    Widget dayStatus = Text(
      "Absent",
      style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 255, 0, 0)),
    );
    if (userAttendance.present_day == 1) {
      dayStatus = Text(
        "Present",
        style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 6, 182, 0)),
      );
    }

    final double totalAttendancePerchentage =
        (userAttendance.total_atended_classes / userAttendance.total_classes);
    final double monthlyAttendancePerchentage =
        (userAttendance.monthly_attended_classes /
            userAttendance.monthly_classes);
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
                        AttendanceGuage(
                          totalAttendance: totalAttendancePerchentage,
                        ),
                        Positioned(
                          bottom: 0,
                          left: MediaQuery.of(context).size.width / 6,
                          child: Text(
                            "${(totalAttendancePerchentage * 100).toStringAsFixed(2)}%",
                            style: TextStyle(
                                fontSize: 35,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
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
                        "${(monthlyAttendancePerchentage * 100).toStringAsFixed(2)}%",
                        style: TextStyle(
                            fontSize: 35, color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      LinearProgressBar(
                        progressPer: monthlyAttendancePerchentage,
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
                      padding: EdgeInsets.all(16.0),
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
