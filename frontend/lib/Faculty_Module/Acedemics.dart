// import 'package:frontend/Faculty_Module/change_acedemics.dart';
// import 'package:frontend/services/ip.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'dart:convert';

// class AcademicsPage extends StatefulWidget {
//   @override
//   _AcademicsPageState createState() => _AcademicsPageState();
// }

// class _AcademicsPageState extends State<AcademicsPage> {
//   var startDates = [];
//   var endDates = [];
//   List<String> holidays = [];
//   final regulationController = TextEditingController();
//   final semesterController = TextEditingController();
//   final totalWorkingDaysForSemesterController = TextEditingController();
//   final totalNumberOfHolidaysController = TextEditingController();
//   final workingDaysForMonthsControllers = <TextEditingController>[];
//   final HolidaysForMonthsControllers = <TextEditingController>[];

//   final noofmonthscontroller = TextEditingController();
//   final HolidaysController = TextEditingController();

//   int numberOfMonths = 0;

//   @override
//   void dispose() {
//     regulationController.dispose();
//     semesterController.dispose();
//     totalWorkingDaysForSemesterController.dispose();
//     totalNumberOfHolidaysController.dispose();
//     workingDaysForMonthsControllers
//         .forEach((controller) => controller.dispose());
//     super.dispose();
//     HolidaysForMonthsControllers.forEach((controller) => controller.dispose());
//     super.dispose();
//   }

//   void uploadAcedemics(
//       String regulation,
//       int semester,
//       int wksemester,
//       int nhsemester,
//       int noofmonths,
//       List<int> HolidaysDaysForMonthsList,
//       List<int> workingDaysForMonthsList,
//       List<dynamic> startDates,
//       List<dynamic> endDates,
//       List<String> holidays) async {
//     try {
//       var response = await http.post(
//         Uri.parse('${ip}/api/semesterdata/'),
//         body: jsonEncode({
//           "Regulation": regulation,
//           "Semester": semester,
//           "TotalWorkingDaysForSem": wksemester,
//           "TotalNumberOfHolidays": nhsemester,
//           "TotalNumberOfMonths": noofmonths,
//           "WorkingDaysForMonth": workingDaysForMonthsList,
//           "HolidaysForMonth": HolidaysDaysForMonthsList,
//           "StartDates": startDates,
//           "EndDates": endDates,
//           "Holidays": holidays
//         }),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );

//       if (response.statusCode == 200) {
//         showDialog(
//           context: context,
//           builder: (ctx) => AlertDialog(
//             title: const Text("Success"),
//             content:
//                 const Text("Acedemics details have been successfully uploaded"),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   // dispose();
//                   Navigator.pop(context);
//                 },
//                 child: const Text("Ok"),
//               ),
//             ],
//           ),
//         );
//       } else if (response.statusCode == 202) {
//         showDialog(
//           context: context,
//           builder: (ctx) => AlertDialog(
//             title: const Text("Error"),
//             content: const Text("Acedemics details have been already uploaded"),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   // dispose();
//                   Navigator.pop(context);
//                 },
//                 child: const Text("Ok"),
//               ),
//             ],
//           ),
//         );
//       }
//       print(response.statusCode);
//       print(jsonDecode(response.body));
//     } catch (err) {
//       print(err);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Academics'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             TextFormField(
//               controller: regulationController,
//               decoration: InputDecoration(labelText: 'Regulation'),
//             ),
//             TextFormField(
//               controller: semesterController,
//               decoration: InputDecoration(labelText: 'Semester'),
//             ),
//             TextFormField(
//               controller: totalWorkingDaysForSemesterController,
//               decoration:
//                   InputDecoration(labelText: 'Total Working Days for Semester'),
//             ),
//             TextFormField(
//               controller: totalNumberOfHolidaysController,
//               decoration:
//                   InputDecoration(labelText: 'Total Number of Holidays'),
//             ),
//             TextFormField(
//               controller: noofmonthscontroller,
//               keyboardType: TextInputType.number,
//               onChanged: (value) {
//                 setState(() {
//                   numberOfMonths = int.tryParse(value) ?? 0;
//                   workingDaysForMonthsControllers.clear();
//                   workingDaysForMonthsControllers.addAll(List.generate(
//                       numberOfMonths, (index) => TextEditingController()));
//                   startDates = List.generate(
//                     numberOfMonths,
//                     (index) => "start date",
//                   );
//                   endDates = List.generate(
//                     numberOfMonths,
//                     (index) => "end date",
//                   );
//                 });
//               },
//               decoration: InputDecoration(labelText: 'Number of Months'),
//             ),
//             if (numberOfMonths > 0) ...generateMonthFields(),
//             // if (numberOfMonths > 0) ...generateMonthHolidayFields(),
//             SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Add Holidays : ",
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.calendar_today),
//                   onPressed: () {
//                     _selectDate(context);
//                   },
//                 ),
//               ],
//             ),
//             Container(
//               height: 100,
//               child: holidays.isEmpty
//                   ? Center(
//                       child: Text(
//                         'There are no holidays',
//                         style: TextStyle(fontSize: 16.0),
//                       ),
//                     )
//                   : ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: holidays.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return InkWell(
//                           onLongPress: () {
//                             setState(() {
//                               holidays.removeAt(index);
//                             });
//                           },
//                           child: Container(
//                             height: 30,
//                             margin: EdgeInsets.all(8.0),
//                             padding: EdgeInsets.all(8.0),
//                             color: Colors.blue,
//                             child: Center(
//                               child: Text(
//                                 holidays[index],
//                                 style: TextStyle(
//                                     fontSize: 16.0, color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//             ),
//             TextButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ChangeAcedemicsScreen()),
//                   );
//                 },
//                 child: Text("update")),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           String regulation = regulationController.text;
//           int semester = int.tryParse(semesterController.text) ?? 0;
//           int wksemester =
//               int.tryParse(totalWorkingDaysForSemesterController.text) ?? 0;
//           int nhsemester =
//               int.tryParse(totalNumberOfHolidaysController.text) ?? 0;
//           int noofmonths = int.tryParse(noofmonthscontroller.text) ?? 0;

//           List<int> workingDaysForMonthsList = [];

//           workingDaysForMonthsControllers.forEach((controller) {
//             int value = int.tryParse(controller.text) ?? 0;
//             workingDaysForMonthsList.add(value);
//           });

//           List<int> HolidaysDaysForMonthsList = [];

//           HolidaysForMonthsControllers.forEach((controller) {
//             int value = int.tryParse(controller.text) ?? 0;
//             HolidaysDaysForMonthsList.add(value);
//           });
//           print('Entered Values:');
//           print('Regulation: $regulation');
//           print('Semester: $semester');
//           print('WKsemester: $wksemester');
//           print('HolidaySemester: $nhsemester');
//           print('No of months: $noofmonths');
//           print('HolidaysDaysForMonthsList: $HolidaysDaysForMonthsList');
//           print('Working Days for Months: $workingDaysForMonthsList');
//           uploadAcedemics(
//               regulation,
//               semester,
//               wksemester,
//               nhsemester,
//               noofmonths,
//               HolidaysDaysForMonthsList,
//               workingDaysForMonthsList,
//               startDates,
//               endDates,
//               holidays);
//         },
//         child: Text("submit"),
//       ),
//     );
//   }

//   List<Widget> generateMonthHolidayFields() {
//     return List.generate(
//       numberOfMonths,
//       (index) => Row(
//         children: [
//           TextFormField(
//             controller: HolidaysForMonthsControllers[index],
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//               labelText: 'Holidays Days for Month ${index + 1}',
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   List<Widget> generateMonthFields() {
//     return List.generate(
//       numberOfMonths,
//       (index) => Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: TextFormField(
//                   controller: workingDaysForMonthsControllers[index],
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     labelText: 'Working Days for Month ${index + 1}',
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.calendar_today),
//                       onPressed: () {
//                         _selectStartDate(context, index);
//                       },
//                     ),
//                     Text(startDates[index])
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.calendar_today),
//                       onPressed: () {
//                         _selectEndDate(context, index);
//                       },
//                     ),
//                     Text(endDates[index])
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 10),
//         ],
//       ),
//     );
//   }

//   String _formatDate(int date) {
//     return date < 10 ? '0$date' : '$date';
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2022),
//       lastDate: DateTime(2025),
//     );
//     if (picked != null) {
//       setState(() {
//         holidays.add(
//             '${picked.year}-${_formatDate(picked.month)}-${_formatDate(picked.day)}');
//       });
//     }
//   }

//   Future<void> _selectStartDate(BuildContext context, int index) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2022),
//       lastDate: DateTime(2025),
//     );
//     if (picked != null) {
//       setState(() {
//         startDates[index] =
//             '${picked.year}-${_formatDate(picked.month)}-${_formatDate(picked.day)}';
//       });
//     }
//   }

//   Future<void> _selectEndDate(BuildContext context, int index) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2022),
//       lastDate: DateTime(2025),
//     );
//     if (picked != null) {
//       setState(() {
//         endDates[index] =
//             '${picked.year}-${_formatDate(picked.month)}-${_formatDate(picked.day)}';
//       });
//     }
//   }
// }

import 'package:frontend/Faculty_Module/change_acedemics.dart';
import 'package:frontend/services/ip.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class AcademicsPage extends StatefulWidget {
  @override
  _AcademicsPageState createState() => _AcademicsPageState();
}

class _AcademicsPageState extends State<AcademicsPage> {
  var startDates = [];
  var endDates = [];
  List<String> holidays = [];
  final regulationController = TextEditingController();
  final semesterController = TextEditingController();
  final totalWorkingDaysForSemesterController = TextEditingController();
  final totalNumberOfHolidaysController = TextEditingController();
  final workingDaysForMonthsControllers = <TextEditingController>[];
  final HolidaysForMonthsControllers = <TextEditingController>[];
  final noofmonthscontroller = TextEditingController();
  final HolidaysController = TextEditingController();
  int numberOfMonths = 0;
  bool _isLoading = false;

  @override
  void dispose() {
    regulationController.dispose();
    semesterController.dispose();
    totalWorkingDaysForSemesterController.dispose();
    totalNumberOfHolidaysController.dispose();
    workingDaysForMonthsControllers
        .forEach((controller) => controller.dispose());
    HolidaysForMonthsControllers.forEach((controller) => controller.dispose());
    noofmonthscontroller.dispose();
    HolidaysController.dispose();
    super.dispose();
  }

  // void resetControllers() {
  //   regulationController.clear();
  //   semesterController.clear();
  //   totalWorkingDaysForSemesterController.clear();
  //   totalNumberOfHolidaysController.clear();
  //   noofmonthscontroller.clear();
  //   workingDaysForMonthsControllers.forEach((controller) => controller.clear());
  //   HolidaysForMonthsControllers.forEach((controller) => controller.clear());
  //   setState(() {
  //     startDates = [];
  //     endDates = [];
  //     holidays = [];
  //   });
  // }

  void uploadAcedemics(
      String regulation,
      int semester,
      int wksemester,
      int nhsemester,
      int noofmonths,
      List<int> HolidaysDaysForMonthsList,
      List<int> workingDaysForMonthsList,
      List<dynamic> startDates,
      List<dynamic> endDates,
      List<String> holidays) async {
    setState(() {
      _isLoading = true;
    });

    try {
      var response = await http.post(
        Uri.parse('${ip}/api/semesterdata/'),
        body: jsonEncode({
          "Regulation": regulation,
          "Semester": semester,
          "TotalWorkingDaysForSem": wksemester,
          "TotalNumberOfHolidays": nhsemester,
          "TotalNumberOfMonths": noofmonths,
          "WorkingDaysForMonth": workingDaysForMonthsList,
          "HolidaysForMonth": HolidaysDaysForMonthsList,
          "StartDates": startDates,
          "EndDates": endDates,
          "Holidays": holidays
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Success"),
            content:
                const Text("Academics details have been successfully uploaded"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ok"))
            ],
          ),
        );
      } else if (response.statusCode == 202) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Error"),
            content: const Text("Academics details have been already uploaded"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Ok"),
              ),
            ],
          ),
        );
      }
      print(response.statusCode);
      print(jsonDecode(response.body));
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Academics'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: regulationController,
                  decoration: InputDecoration(
                    labelText: 'Regulation',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 17, 79, 90),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: semesterController,
                  decoration: InputDecoration(
                    labelText: 'Semester',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 17, 79, 90),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: totalWorkingDaysForSemesterController,
                  decoration: InputDecoration(
                    labelText: 'Total Working Days for Semester',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 17, 79, 90),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: totalNumberOfHolidaysController,
                  decoration: InputDecoration(
                    labelText: 'Total Number of Holidays',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 17, 79, 90),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: noofmonthscontroller,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      numberOfMonths = int.tryParse(value) ?? 0;
                      workingDaysForMonthsControllers.clear();
                      workingDaysForMonthsControllers.addAll(List.generate(
                          numberOfMonths, (index) => TextEditingController()));
                      startDates = List.generate(
                        numberOfMonths,
                        (index) => "start date",
                      );
                      endDates = List.generate(
                        numberOfMonths,
                        (index) => "end date",
                      );
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Number of Months',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 17, 79, 90),
                    ),
                  ),
                ),
                if (numberOfMonths > 0) ...generateMonthFields(),
                // if (numberOfMonths > 0) ...generateMonthHolidayFields(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add Holidays : ",
                      style: TextStyle(
                          fontSize: 20, color: Color.fromARGB(255, 17, 79, 90)),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                  ],
                ),
                Container(
                  height: 100,
                  child: holidays.isEmpty
                      ? Center(
                          child: Text(
                            'There are no holidays',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: holidays.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onLongPress: () {
                                setState(() {
                                  holidays.removeAt(index);
                                });
                              },
                              child: Container(
                                height: 30,
                                margin: EdgeInsets.all(8.0),
                                padding: EdgeInsets.all(8.0),
                                color: Colors.blue,
                                child: Center(
                                  child: Text(
                                    holidays[index],
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeAcedemicsScreen()),
                    );
                  },
                  child: Text(
                    "update",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color.fromARGB(
                        255,
                        251,
                        171,
                        58,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    String regulation = regulationController.text;
                    int semester = int.tryParse(semesterController.text) ?? 0;
                    int wksemester = int.tryParse(
                            totalWorkingDaysForSemesterController.text) ??
                        0;
                    int nhsemester =
                        int.tryParse(totalNumberOfHolidaysController.text) ?? 0;
                    int noofmonths =
                        int.tryParse(noofmonthscontroller.text) ?? 0;

                    List<int> workingDaysForMonthsList = [];

                    workingDaysForMonthsControllers.forEach((controller) {
                      int value = int.tryParse(controller.text) ?? 0;
                      workingDaysForMonthsList.add(value);
                    });

                    List<int> HolidaysDaysForMonthsList = [];

                    HolidaysForMonthsControllers.forEach((controller) {
                      int value = int.tryParse(controller.text) ?? 0;
                      HolidaysDaysForMonthsList.add(value);
                    });
                    print('Entered Values:');
                    print('Regulation: $regulation');
                    print('Semester: $semester');
                    print('WKsemester: $wksemester');
                    print('HolidaySemester: $nhsemester');
                    print('No of months: $noofmonths');
                    print(
                        'HolidaysDaysForMonthsList: $HolidaysDaysForMonthsList');
                    print('Working Days for Months: $workingDaysForMonthsList');
                    uploadAcedemics(
                        regulation,
                        semester,
                        wksemester,
                        nhsemester,
                        noofmonths,
                        HolidaysDaysForMonthsList,
                        workingDaysForMonthsList,
                        startDates,
                        endDates,
                        holidays);
                  },
                  child: Text(
                    "submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 17, 79, 90),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     String regulation = regulationController.text;
      //     int semester = int.tryParse(semesterController.text) ?? 0;
      //     int wksemester =
      //         int.tryParse(totalWorkingDaysForSemesterController.text) ?? 0;
      //     int nhsemester =
      //         int.tryParse(totalNumberOfHolidaysController.text) ?? 0;
      //     int noofmonths = int.tryParse(noofmonthscontroller.text) ?? 0;

      //     List<int> workingDaysForMonthsList = [];

      //     workingDaysForMonthsControllers.forEach((controller) {
      //       int value = int.tryParse(controller.text) ?? 0;
      //       workingDaysForMonthsList.add(value);
      //     });

      //     List<int> HolidaysDaysForMonthsList = [];

      //     HolidaysForMonthsControllers.forEach((controller) {
      //       int value = int.tryParse(controller.text) ?? 0;
      //       HolidaysDaysForMonthsList.add(value);
      //     });
      //     print('Entered Values:');
      //     print('Regulation: $regulation');
      //     print('Semester: $semester');
      //     print('WKsemester: $wksemester');
      //     print('HolidaySemester: $nhsemester');
      //     print('No of months: $noofmonths');
      //     print('HolidaysDaysForMonthsList: $HolidaysDaysForMonthsList');
      //     print('Working Days for Months: $workingDaysForMonthsList');
      //     uploadAcedemics(
      //         regulation,
      //         semester,
      //         wksemester,
      //         nhsemester,
      //         noofmonths,
      //         HolidaysDaysForMonthsList,
      //         workingDaysForMonthsList,
      //         startDates,
      //         endDates,
      //         holidays);
      //   },
      //   child: Text("submit"),
      // ),
    );
  }

  List<Widget> generateMonthHolidayFields() {
    return List.generate(
      numberOfMonths,
      (index) => Row(
        children: [
          TextFormField(
            controller: HolidaysForMonthsControllers[index],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Holidays Days for Month ${index + 1}',
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> generateMonthFields() {
    return List.generate(
      numberOfMonths,
      (index) => Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: workingDaysForMonthsControllers[index],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Working Days for Month ${index + 1}',
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        _selectStartDate(context, index);
                      },
                    ),
                    Text(startDates[index])
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        _selectEndDate(context, index);
                      },
                    ),
                    Text(endDates[index])
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  String _formatDate(int date) {
    return date < 10 ? '0$date' : '$date';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        holidays.add(
            '${picked.year}-${_formatDate(picked.month)}-${_formatDate(picked.day)}');
      });
    }
  }

  Future<void> _selectStartDate(BuildContext context, int index) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        startDates[index] =
            '${picked.year}-${_formatDate(picked.month)}-${_formatDate(picked.day)}';
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context, int index) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        endDates[index] =
            '${picked.year}-${_formatDate(picked.month)}-${_formatDate(picked.day)}';
      });
    }
  }
}
