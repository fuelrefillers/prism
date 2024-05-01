import 'package:flutter/material.dart';
import 'package:frontend/screens/subjects_screens/attendance_screen.dart';

class IndividualSubjectsScreen extends StatefulWidget {
  final String title;
  final String subjectCode;
  final String rollno;
  const IndividualSubjectsScreen(
      {super.key,
      required this.subjectCode,
      required this.title,
      required this.rollno});

  @override
  State<IndividualSubjectsScreen> createState() =>
      _IndividualSubjectsScreenState();
}

class _IndividualSubjectsScreenState extends State<IndividualSubjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(
                      108, 75, 192, 213), // Light orange color for selected
                  // Transparent if not booked
                  border: Border.all(
                    color: Color.fromARGB(255, 105, 210, 228),
                    // Border color based on booked status
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 90,
                width: MediaQuery.of(context).size.width - 24,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.menu_book_outlined,
                        size: 40,
                      ),
                      Text(
                        "Lesson Plan",
                        style: TextStyle(
                          fontSize: 30,
                        ), // Text color based on selection
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 17,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(
                      108, 75, 192, 213), // Light orange color for selected
                  // Transparent if not booked
                  border: Border.all(
                    color: Color.fromARGB(255, 105, 210, 228),
                    // Border color based on booked status
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 90,
                width: MediaQuery.of(context).size.width - 16,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.assessment,
                        size: 40,
                      ),
                      Text(
                        "Assignments",
                        style: TextStyle(
                          fontSize: 30,
                        ), // Text color based on selection
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 17,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          108, 75, 192, 213), // Light orange color for selected
                      // Transparent if not booked
                      border: Border.all(
                        color: Color.fromARGB(255, 105, 210, 228),
                        // Border color based on booked status
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 90,
                    width: MediaQuery.of(context).size.width / 3 - 20,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.task,
                            size: 30,
                          ),
                          Text(
                            "Tasks",
                            style: TextStyle(
                              fontSize: 15,
                            ), // Text color based on selection
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          108, 75, 192, 213), // Light orange color for selected
                      // Transparent if not booked
                      border: Border.all(
                        color: Color.fromARGB(255, 105, 210, 228),
                        // Border color based on booked status
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 90,
                    width: MediaQuery.of(context).size.width / 3 - 20,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info,
                            size: 30,
                          ),
                          Text(
                            "Subject info",
                            style: TextStyle(
                              fontSize: 15,
                            ), // Text color based on selection
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubjectAttendance(
                                rollno: widget.rollno,
                                subjectcode: widget.subjectCode)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          108, 75, 192, 213), // Light orange color for selected
                      // Transparent if not booked
                      border: Border.all(
                        color: Color.fromARGB(255, 105, 210, 228),
                        // Border color based on booked status
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 90,
                    width: MediaQuery.of(context).size.width / 3 - 20,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_task_rounded,
                            size: 30,
                          ),
                          Text(
                            "Attendance",
                            style: TextStyle(
                              fontSize: 15,
                            ), // Text color based on selection
                          )
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
