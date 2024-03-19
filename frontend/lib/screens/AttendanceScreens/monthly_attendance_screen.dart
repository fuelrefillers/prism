import 'package:flutter/material.dart';
import 'package:frontend/providers.dart/attendance_provider.dart';
import 'package:frontend/widgets/attendance_guage.dart';
import 'package:provider/provider.dart';

class SummaryContainer extends StatelessWidget {
  final String text1;
  final String text2;
  final String number;
  final Color containerColor;
  final TextStyle? text1Style;
  final TextStyle? numberStyle;
  final TextStyle? text2Style;

  const SummaryContainer({
    required this.text1,
    required this.text2,
    required this.number,
    required this.containerColor,
    this.text1Style,
    this.numberStyle,
    this.text2Style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      width: MediaQuery.of(context).size.width / 3.59,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.28),
            offset: Offset(0, 2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                text1,
                style: text1Style ?? TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Text(
                number,
                style: numberStyle ??
                    TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Text(
                text2,
                style: text2Style ??
                    TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MonthlyAttendance extends StatelessWidget {
  const MonthlyAttendance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userAttendance = Provider.of<AttendanceProvider>(context).attendance;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Monthly Attendance'),
            const Spacer(),
            Image.asset('assets/MREC_logo.png',
                height: MediaQuery.of(context).size.height / 8,
                width: MediaQuery.of(context).size.width / 8),
          ],
        ),
      ),
      backgroundColor: Color(0xFFF7F8Fb),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Monthly Attendance summary',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20.0),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.28),
                    offset: Offset(0, 2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                color: Colors.white,
                surfaceTintColor: Colors.blue,
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
            const SizedBox(
              height: 25.0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: const Row(
                children: [
                  SummaryContainer(
                    text1: 'Total',
                    number: '90',
                    text2: 'Days',
                    containerColor: Colors.white,
                    text1Style: TextStyle(fontSize: 16.0, color: Colors.black),
                    numberStyle: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    text2Style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 15.0),
                  SummaryContainer(
                    text1: 'Attended',
                    number: '45',
                    text2: 'Days',
                    containerColor: Colors.white,
                    text1Style: TextStyle(fontSize: 16.0, color: Colors.black),
                    numberStyle: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    text2Style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 15.0),
                  SummaryContainer(
                    text1: 'Leaves',
                    number: '19',
                    text2: 'Days',
                    containerColor: Color(0xFF114F5A),
                    text1Style: TextStyle(fontSize: 16.0, color: Colors.white),
                    numberStyle: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    text2Style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
