import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/change_acedemics.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: AcademicsPage(),
//     );
//   }
// }

class AcademicsPage extends StatefulWidget {
  @override
  _AcademicsPageState createState() => _AcademicsPageState();
}

class _AcademicsPageState extends State<AcademicsPage> {
  final regulationController = TextEditingController();
  final semesterController = TextEditingController();
  final totalWorkingDaysForSemesterController = TextEditingController();
  final totalNumberOfHolidaysController = TextEditingController();
  final workingDaysForMonthsControllers = <TextEditingController>[];
  final noofmonthscontroller = TextEditingController();
  int numberOfMonths = 0;

  @override
  void dispose() {
    regulationController.dispose();
    semesterController.dispose();
    totalWorkingDaysForSemesterController.dispose();
    totalNumberOfHolidaysController.dispose();
    workingDaysForMonthsControllers
        .forEach((controller) => controller.dispose());
    super.dispose();
  }

  void uploadAcedemics(
      String regulation,
      int semester,
      int wksemester,
      int nhsemester,
      int noofmonths,
      List<int> HolidaysDaysForMonthsList,
      List<int> workingDaysForMonthsList) async {
    try {
      var response = await http.post(
        Uri.parse('http://15.20.17.222:3000/api/semesterdata/'),
        body: jsonEncode({
          "Regulation": regulation,
          "Semester": semester,
          "TotalWorkingDaysForSem": wksemester,
          "TotalNumberOfHolidays": nhsemester,
          "TotalNumberOfMonths": noofmonths,
          "WorkingDaysForMonth": HolidaysDaysForMonthsList,
          "HolidaysForMonth": workingDaysForMonthsList,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.statusCode);
      print(jsonDecode(response.body));
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Academics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: regulationController,
              decoration: InputDecoration(labelText: 'Regulation'),
            ),
            TextFormField(
              controller: semesterController,
              decoration: InputDecoration(labelText: 'Semester'),
            ),
            TextFormField(
              controller: totalWorkingDaysForSemesterController,
              decoration:
                  InputDecoration(labelText: 'Total Working Days for Semester'),
            ),
            TextFormField(
              controller: totalNumberOfHolidaysController,
              decoration:
                  InputDecoration(labelText: 'Total Number of Holidays'),
            ),
            TextFormField(
              controller: noofmonthscontroller,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  numberOfMonths = int.tryParse(value) ?? 0;
                  workingDaysForMonthsControllers.clear();
                  workingDaysForMonthsControllers.addAll(List.generate(
                      numberOfMonths, (index) => TextEditingController()));
                });
              },
              decoration: InputDecoration(labelText: 'Number of Months'),
            ),
            if (numberOfMonths > 0) ...generateMonthFields(),
            TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeAcedemicsScreen()),
                      (route) => false);
                },
                child: Text("update"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String regulation = regulationController.text;
          int semester = int.tryParse(semesterController.text) ?? 0;
          int wksemester =
              int.tryParse(totalWorkingDaysForSemesterController.text) ?? 0;
          int nhsemester =
              int.tryParse(totalNumberOfHolidaysController.text) ?? 0;
          int noofmonths = int.tryParse(noofmonthscontroller.text) ?? 0;

          List<int> workingDaysForMonthsList = [];

          workingDaysForMonthsControllers.forEach((controller) {
            int value = int.tryParse(controller.text) ?? 0;
            workingDaysForMonthsList.add(value);
          });

          List<int> HolidaysDaysForMonthsList = [];

          workingDaysForMonthsControllers.forEach((controller) {
            HolidaysDaysForMonthsList.add(0);
          });
          print('Entered Values:');
          print('Regulation: $regulation');
          print('Semester: $semester');
          print('WKsemester: $wksemester');
          print('HolidaySemester: $nhsemester');
          print('No of months: $noofmonths');
          print('HolidaysDaysForMonthsList: $HolidaysDaysForMonthsList');

          print('Working Days for Months: $workingDaysForMonthsList');

          uploadAcedemics(regulation, semester, wksemester, nhsemester,
              noofmonths, HolidaysDaysForMonthsList, workingDaysForMonthsList);
        },
        child: Text("submit"),
      ),
    );
  }

  List<Widget> generateMonthFields() {
    return List.generate(
      numberOfMonths,
      (index) => TextFormField(
        controller: workingDaysForMonthsControllers[index],
        keyboardType: TextInputType.number,
        decoration:
            InputDecoration(labelText: 'Working Days for Month ${index + 1}'),
      ),
    );
  }
}
