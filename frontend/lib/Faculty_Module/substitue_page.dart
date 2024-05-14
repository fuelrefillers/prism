// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:frontend/Faculty_Module/main_screen.dart';
// import 'package:frontend/Faculty_Module/substitute_data_model.dart';
// import 'package:frontend/models/faculty_time_table_model.dart';
// import 'package:frontend/models/substitute_model.dart';
// import 'package:frontend/providers/faculty_provider.dart';
// import 'package:frontend/providers/time_table_view_provider.dart';
// import 'package:frontend/services/ip.dart';
// import 'package:frontend/util/util.dart';
// import 'package:frontend/widgets/multi_purpose_card.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;

// class SubstitutePage extends StatefulWidget {
//   const SubstitutePage({super.key});

//   @override
//   State<SubstitutePage> createState() => _SubstitutePageState();
// }

// class _SubstitutePageState extends State<SubstitutePage>
//     with SingleTickerProviderStateMixin {
//   late TabController _controller;

//   String selectedDateSS = '';
//   String selectedWeekdaySS = '';
//   List<String> _periods = [
//     "09:30-10:20",
//     "10:20-11:10",
//     "11:20-12:10",
//     "12:10-01:00",
//     "01:45-02:35",
//     "02:35-03:25",
//     "03:25-04:15"
//   ];
//   String _selectedPeriod = "09:30-10:20";
//   SubstitueModel assigningPeriod = SubstitueModel(
//       Date: "",
//       Day: "",
//       StartTime: "",
//       EndTime: "",
//       Department: "",
//       Section: "",
//       Regulation: "",
//       Year: "");
//   SubstituteModelFORDROP _selectedFaculty =
//       SubstituteModelFORDROP(FacultyId: "", FacultyName: "");
//   List<SubstituteModelFORDROP> dumm = [];
//   bool fetchInit = false;
//   bool fetched = false;

//   final TextEditingController departmentController = TextEditingController();

//   @override
//   void initState() {
//     _controller = TabController(length: 3, vsync: this, initialIndex: 1);
//     super.initState();
//   }

//   DateTime? selectedDateTime;

//   Future<void> selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2022),
//       lastDate: DateTime(2025),
//     );
//     if (picked != null) {
//       setState(() {
//         selectedDateTime = picked;
//         selectedDateSS = DateFormat('yyyy-MM-dd').format(picked);
//         selectedWeekdaySS = DateFormat('EEEE').format(picked);
//       });
//     }
//   }

//   void sendRequiest() async {
//     try {
//       http.Response res = await http.post(
//         Uri.parse('${ip}/api/faculty/settSubstitute'),
//         body: jsonEncode({
//           "facultyId": _selectedFaculty.FacultyId,
//           "facultyName": _selectedFaculty.FacultyName,
//           "startTime": assigningPeriod.StartTime,
//           "endTime": assigningPeriod.EndTime,
//           "date": assigningPeriod.Date,
//           "day": assigningPeriod.Day,
//           "department": assigningPeriod.Department,
//           "section": assigningPeriod.Section,
//           "regulation": assigningPeriod.Regulation,
//           "year": "3"
//         }),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );
//       if (res.statusCode == 200) {
//         showDialog(
//           context: context,
//           builder: (ctx) => AlertDialog(
//             title: const Text("Conformation"),
//             content: const Text("Click ok to Submit and go back to main page"),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   setState(() {
//                     departmentController.clear();
//                     selectedWeekdaySS = '';
//                     selectedDateSS = '';
//                     fetched = false;
//                   });
//                   Navigator.pop(context);
//                 },
//                 child: const Text("Okay"),
//               ),
//             ],
//           ),
//         );
//       } else {
//         showDialog(
//           context: context,
//           builder: (ctx) => AlertDialog(
//             title: const Text("Conformation"),
//             content: const Text("Something went wrong"),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text("Okay"),
//               ),
//             ],
//           ),
//         );
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   void getKali() async {
//     setState(() {
//       fetchInit = true;
//     });
//     List<String> splitTime = _selectedPeriod.split("-");
//     String startTime = splitTime[0];
//     String endTime = splitTime[1];
//     try {
//       http.Response res = await http.post(
//         Uri.parse(
//             '${ip}/api/faculty/assignsubstitute?facultyDepartment=${departmentController.text.toUpperCase()}&day=${selectedWeekdaySS}'),
//         body: jsonEncode({
//           "StartTime": startTime,
//           "EndTime": endTime,
//         }),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );
//       // print(res.body);
//       if (res.statusCode == 200) {
//         // print(res.body);
//         List<SubstituteModelFORDROP> tepm = [];
//         var result = jsonDecode(res.body);
//         for (int i = 0; i < result.length; i++) {
//           SubstituteModelFORDROP s =
//               SubstituteModelFORDROP.fromMap(result[i] as Map<String, dynamic>);
//           tepm.add(s);
//         }
//         setState(() {
//           print(tepm);
//           dumm = tepm;
//           _selectedFaculty = tepm[0];
//           fetchInit = false;
//           fetched = true;
//         });
//       } else if (res.statusCode == 201) {
//         setState(() {
//           fetchInit = false;
//           fetched = true;
//         });
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> acceptORreject(
//       {required String decision,
//       required FacultyTimeTable TM,
//       required int index}) async {
//     try {
//       print("hello");
//       http.Response res = await http.post(
//         Uri.parse('${ip}/api/faculty/acceptRequest?accepted=${decision}'),
//         body: jsonEncode({
//           "facultyId": TM.FacultyId,
//           "facultyName": TM.FacultyName,
//           "index": index
//         }),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );

//       print(res);

//       if (res.statusCode == 200 && decision == "true") {
//         showDialog(
//           context: context,
//           builder: (ctx) => AlertDialog(
//             title: const Text("Conformation"),
//             content: const Text("request Sent"),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text("Okay"),
//               ),
//             ],
//           ),
//         );
//       } else if (res.statusCode == 200 && decision == "false") {
//         showDialog(
//           context: context,
//           builder: (ctx) => AlertDialog(
//             title: const Text("Conformation"),
//             content: const Text("request deleted"),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text("Okay"),
//               ),
//             ],
//           ),
//         );
//       } else {
//         showDialog(
//           context: context,
//           builder: (ctx) => AlertDialog(
//             title: const Text("Conformation"),
//             content: const Text("something went wrong"),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text("Okay"),
//               ),
//             ],
//           ),
//         );
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   bool checked({required FacultyTimeTable timeTable}) {
//     List<String> splitTime = _selectedPeriod.split("-");
//     String startTime = splitTime[0];
//     String endTime = splitTime[1];
//     int dayIndex = selectedDateTime!.weekday;
//     List<FPeriods> fp = timeTable.TimeTable[dayIndex - 1].Periods;
//     print(fp[0].StartTime);
//     print(startTime);
//     print(endTime);
//     for (var period in fp) {
//       if (period.StartTime == startTime && period.EndTime == endTime) {
//         print(period.Department);
//         setState(() {
//           assigningPeriod = SubstitueModel(
//               Date: selectedDateSS,
//               Day: selectedWeekdaySS,
//               StartTime: period.StartTime,
//               EndTime: period.EndTime,
//               Department: period.Department,
//               Section: period.Section,
//               Regulation: period.Regulation,
//               Year: period.Year);
//         });
//         return true;
//       }
//     }
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final faculty =
//         Provider.of<FacultyProvider>(context, listen: false).faculty;
//     List<SubstitueModel> tt = faculty.InQueueSubstituteInfo;
//     List<SubstitueModel> ff = faculty.AcceptedSubstitueInfo;
//     final FTP = Provider.of<FacultyTimeTableProvider>(context, listen: false)
//         .facultyTimeTable;

//     Widget substitutes = Column(
//       children: [
//         faculty.AcceptedSubstitueInfo.isEmpty
//             ? Center(
//                 child: Text("NO SUBSTITUTIONS"),
//               )
//             : Expanded(
//                 child: ListView.builder(
//                   itemCount: faculty.AcceptedSubstitueInfo.length,
//                   itemBuilder: (context, index) => MultiPurposeCard(
//                     category:
//                         "${faculty.AcceptedSubstitueInfo[index].Department}-${faculty.AcceptedSubstitueInfo[index].Section}  ${faculty.AcceptedSubstitueInfo[index].Regulation}",
//                     subcategory:
//                         "${faculty.AcceptedSubstitueInfo[index].Date} time : ${faculty.AcceptedSubstitueInfo[index].StartTime}-${faculty.AcceptedSubstitueInfo[index].EndTime}",
//                     subcategory1: "",
//                     height1: 90,
//                     screen: MainScreen(
//                       department:
//                           faculty.AcceptedSubstitueInfo[index].Department,
//                       section: faculty.AcceptedSubstitueInfo[index].Section,
//                       regulation:
//                           faculty.AcceptedSubstitueInfo[index].Regulation,
//                       startTime: faculty.AcceptedSubstitueInfo[index].StartTime,
//                       endTime: faculty.AcceptedSubstitueInfo[index].EndTime,
//                       selectedDate: DateTime.now(),
//                     ),
//                   ),
//                 ),
//               ),
//       ],
//     );

//     Widget AcceptRequest = Column(
//       children: [
//         tt.isEmpty
//             ? Center(
//                 child: Text("NO REQUESTS"),
//               )
//             : Expanded(
//                 child: ListView.builder(
//                   itemCount: tt.length,
//                   itemBuilder: (context, index) => Container(
//                     child: Column(
//                       children: [
//                         Text(
//                             "${tt[index].Date} ${tt[index].Department}-${tt[index].Section} ${index}"),
//                         Row(
//                           children: [
//                             ElevatedButton(
//                               onPressed: () async {
//                                 await acceptORreject(
//                                     decision: "false", TM: FTP, index: index);
//                                 setState(() {
//                                   tt.removeAt(index);
//                                 });
//                               },
//                               child: Text("Cancel"),
//                             ),
//                             ElevatedButton(
//                               onPressed: () async {
//                                 await acceptORreject(
//                                     decision: "true", TM: FTP, index: index);
//                                 setState(() {
//                                   ff.add(tt[index]);
//                                   tt.removeAt(index);
//                                 });
//                               },
//                               child: Text("accept"),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//       ],
//     );

//     Widget SendRequests = Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 16),
//             TextFormField(
//               keyboardType: TextInputType.text,
//               controller: departmentController,
//               decoration: InputDecoration(
//                 labelText: "Enter the Department Name",
//                 fillColor: Color.fromARGB(255, 215, 224, 243),
//                 filled: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25.0),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             Text('Select Date :'),
//             SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton(
//                   onPressed: () async {
//                     selectDate(context);
//                   },
//                   child: Text('Pick a date'),
//                 ),
//                 Text("$selectedDateSS - $selectedWeekdaySS"),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             DropdownButtonFormField<String>(
//               value: _selectedPeriod,
//               onChanged: (newValue) {
//                 setState(() {
//                   _selectedPeriod = newValue!;
//                 });
//               },
//               items: _periods.map((department) {
//                 return DropdownMenuItem<String>(
//                   value: department,
//                   child: Text(department),
//                 );
//               }).toList(),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Center(
//                 child: ElevatedButton(
//                     onPressed: () {
//                       if (checked(timeTable: FTP)) {
//                         getKali();
//                       } else {
//                         showSnackBar(context,
//                             "you dont have period for the selected time");
//                       }
//                     },
//                     child: Text("search"))),
//             fetchInit
//                 ? Center(
//                     child: CircularProgressIndicator.adaptive(),
//                   )
//                 : fetched
//                     ? dumm.isEmpty
//                         ? Center(
//                             child: Text("No faculty are free"),
//                           )
//                         : Column(
//                             children: [
//                               DropdownButtonFormField<SubstituteModelFORDROP>(
//                                 value: _selectedFaculty,
//                                 onChanged: (newValue) {
//                                   setState(() {
//                                     _selectedFaculty = newValue!;
//                                   });
//                                 },
//                                 items: dumm
//                                     .map((SubstituteModelFORDROP department) {
//                                   return DropdownMenuItem<
//                                       SubstituteModelFORDROP>(
//                                     value: department,
//                                     child: Text(
//                                         "${department.FacultyName}-${department.FacultyId}"),
//                                   );
//                                 }).toList(),
//                               ),
//                               SizedBox(
//                                 height: 30,
//                               ),
//                               ElevatedButton(
//                                 onPressed: () {
//                                   sendRequiest();
//                                 },
//                                 child: Text("Send Request"),
//                               ),
//                             ],
//                           )
//                     : Text("Select date and search to get results"),
//           ],
//         ),
//       ),
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Substitute Page"),
//         bottom: TabBar(
//           // isScrollable: true,
//           controller: _controller,
//           indicatorColor: const Color.fromARGB(255, 251, 171, 58),
//           tabs: [
//             Tab(
//               text: "Send Requests",
//             ),
//             Tab(
//               text: "Substitutes",
//             ),
//             Tab(
//               text: "Requests",
//             )
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _controller,
//         children: [
//           SendRequests,
//           substitutes,
//           AcceptRequest,
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/main_screen.dart';
import 'package:frontend/Faculty_Module/substitute_data_model.dart';
import 'package:frontend/models/faculty_model.dart';
import 'package:frontend/models/faculty_time_table_model.dart';
import 'package:frontend/models/substitute_model.dart';
import 'package:frontend/providers/faculty_provider.dart';
import 'package:frontend/providers/time_table_view_provider.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/services/faculty_services.dart';
import 'package:frontend/services/ip.dart';
import 'package:frontend/services/prismBloc/prism_bloc.dart';
import 'package:frontend/services/repo.dart';
import 'package:frontend/util/util.dart';
import 'package:frontend/widgets/multi_purpose_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SubstitutePage extends StatefulWidget {
  const SubstitutePage({super.key});

  @override
  State<SubstitutePage> createState() => _SubstitutePageState();
}

class _SubstitutePageState extends State<SubstitutePage>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  late TabController _controller;

  String selectedDateSS = '';
  String selectedWeekdaySS = '';
  List<String> _periods = [
    "09:30-10:20",
    "10:20-11:10",
    "11:20-12:10",
    "12:10-01:00",
    "01:45-02:35",
    "02:35-03:25",
    "03:25-04:15"
  ];
  String _selectedPeriod = "09:30-10:20";
  SubstitueModel assigningPeriod = SubstitueModel(
      Date: "",
      Day: "",
      StartTime: "",
      EndTime: "",
      Department: "",
      Section: "",
      Regulation: "",
      Year: "");
  SubstituteModelFORDROP _selectedFaculty =
      SubstituteModelFORDROP(FacultyId: "", FacultyName: "");
  List<SubstituteModelFORDROP> dumm = [];
  bool fetchInit = false;
  bool fetched = false;

  Faculty faculty = Faculty(
      FacultyId: "",
      FacultyName: "",
      FacultyDesignation: "",
      FacultyPhnNo: "",
      FacultyDepartment: "",
      Classes: [],
      IsAdmin: false,
      AcceptedSubstitueInfo: [],
      InQueueSubstituteInfo: []);

  final TextEditingController departmentController = TextEditingController();

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this, initialIndex: 1);
    super.initState();
    PrismRepo.getFacultyInsideSub(context: context);
    loadFacultyProvider();
  }

  void loadFacultyProvider() {
    setState(() {
      faculty = Provider.of<FacultyProvider>(context, listen: false).faculty;
    });
  }

  DateTime? selectedDateTime;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        selectedDateTime = picked;
        selectedDateSS = DateFormat('yyyy-MM-dd').format(picked);
        selectedWeekdaySS = DateFormat('EEEE').format(picked);
      });
    }
  }

  void sendRequiest() async {
    try {
      http.Response res = await http.post(
        Uri.parse('${ip}/api/faculty/settSubstitute'),
        body: jsonEncode({
          "facultyId": _selectedFaculty.FacultyId,
          "facultyName": _selectedFaculty.FacultyName,
          "startTime": assigningPeriod.StartTime,
          "endTime": assigningPeriod.EndTime,
          "date": assigningPeriod.Date,
          "day": assigningPeriod.Day,
          "department": assigningPeriod.Department,
          "section": assigningPeriod.Section,
          "regulation": assigningPeriod.Regulation,
          "year": "3"
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Conformation"),
            content: const Text("Click ok to Submit and go back to main page"),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    departmentController.clear();
                    selectedWeekdaySS = '';
                    selectedDateSS = '';
                    fetched = false;
                  });
                  Navigator.pop(context);
                },
                child: const Text("Okay"),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Conformation"),
            content: const Text("Something went wrong"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Okay"),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void getKali() async {
    setState(() {
      fetchInit = true;
    });
    List<String> splitTime = _selectedPeriod.split("-");
    String startTime = splitTime[0];
    String endTime = splitTime[1];
    try {
      http.Response res = await http.post(
        Uri.parse(
            '${ip}/api/faculty/assignsubstitute?facultyDepartment=${departmentController.text.toUpperCase()}&day=${selectedWeekdaySS}'),
        body: jsonEncode({
          "StartTime": startTime,
          "EndTime": endTime,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // print(res.body);
      if (res.statusCode == 200) {
        // print(res.body);
        List<SubstituteModelFORDROP> tepm = [];
        var result = jsonDecode(res.body);
        for (int i = 0; i < result.length; i++) {
          SubstituteModelFORDROP s =
              SubstituteModelFORDROP.fromMap(result[i] as Map<String, dynamic>);
          tepm.add(s);
        }
        setState(() {
          print(tepm);
          dumm = tepm;
          _selectedFaculty = tepm[0];
          fetchInit = false;
          fetched = true;
        });
      } else if (res.statusCode == 201) {
        setState(() {
          fetchInit = false;
          fetched = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> acceptORreject(
      {required String decision,
      required FacultyTimeTable TM,
      required int index}) async {
    try {
      print("hello");
      http.Response res = await http.post(
        Uri.parse('${ip}/api/faculty/acceptRequest?accepted=${decision}'),
        body: jsonEncode({
          "facultyId": TM.FacultyId,
          "facultyName": TM.FacultyName,
          "index": index
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print(res);

      if (res.statusCode == 200 && decision == "true") {
        setState(() {
          _isLoading = false;
        });
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Conformation"),
            content: const Text("request Accepted"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Okay"),
              ),
            ],
          ),
        );
      } else if (res.statusCode == 200 && decision == "false") {
        setState(() {
          _isLoading = false;
        });
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Conformation"),
            content: const Text("request deleted"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Okay"),
              ),
            ],
          ),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Conformation"),
            content: const Text("something went wrong"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Okay"),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  bool checked({required FacultyTimeTable timeTable}) {
    List<String> splitTime = _selectedPeriod.split("-");
    String startTime = splitTime[0];
    String endTime = splitTime[1];
    int dayIndex = selectedDateTime!.weekday;
    List<FPeriods> fp = timeTable.TimeTable[dayIndex - 1].Periods;
    print(fp[0].StartTime);
    print(startTime);
    print(endTime);
    for (var period in fp) {
      if (period.StartTime == startTime && period.EndTime == endTime) {
        print(period.Department);
        setState(() {
          assigningPeriod = SubstitueModel(
              Date: selectedDateSS,
              Day: selectedWeekdaySS,
              StartTime: period.StartTime,
              EndTime: period.EndTime,
              Department: period.Department,
              Section: period.Section,
              Regulation: period.Regulation,
              Year: period.Year);
        });
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // final faculty =
    //     Provider.of<FacultyProvider>(context, listen: false).faculty;
    List<SubstitueModel> tt = faculty.InQueueSubstituteInfo;
    List<SubstitueModel> ff = faculty.AcceptedSubstitueInfo;
    final FTP = Provider.of<FacultyTimeTableProvider>(context, listen: false)
        .facultyTimeTable;

    Widget substitutes = Column(
      children: [
        faculty.AcceptedSubstitueInfo.isEmpty
            ? Center(
                child: Text("NO SUBSTITUTIONS"),
              )
            : Expanded(
                child: ListView.builder(
                  itemCount: faculty.AcceptedSubstitueInfo.length,
                  itemBuilder: (context, index) => MultiPurposeCard(
                    category:
                        "${faculty.AcceptedSubstitueInfo[index].Department}-${faculty.AcceptedSubstitueInfo[index].Section}  ${faculty.AcceptedSubstitueInfo[index].Regulation}",
                    subcategory:
                        "${faculty.AcceptedSubstitueInfo[index].Date} time : ${faculty.AcceptedSubstitueInfo[index].StartTime}-${faculty.AcceptedSubstitueInfo[index].EndTime}",
                    subcategory1: "",
                    height1: 90,
                    screen: MainScreen(
                      department:
                          faculty.AcceptedSubstitueInfo[index].Department,
                      section: faculty.AcceptedSubstitueInfo[index].Section,
                      regulation:
                          faculty.AcceptedSubstitueInfo[index].Regulation,
                      startTime: faculty.AcceptedSubstitueInfo[index].StartTime,
                      endTime: faculty.AcceptedSubstitueInfo[index].EndTime,
                      selectedDate: DateTime.now(),
                    ),
                  ),
                ),
              ),
      ],
    );

    Widget AcceptRequest = Stack(
      children: [
        Column(
          children: [
            tt.isEmpty
                ? Center(
                    child: Text("NO REQUESTS"),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: tt.length,
                      itemBuilder: (context, index) => Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text("${index + 1}"),
                          ),
                          title: Text(
                              "${tt[index].Department} - ${tt[index].Section} - ${tt[index].Regulation}"),
                          subtitle: Text(
                              "${tt[index].Date} - ${tt[index].StartTime} - ${tt[index].EndTime}"),
                          trailing: Wrap(
                            spacing: 12,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await acceptORreject(
                                      decision: "false", TM: FTP, index: index);
                                  setState(() {
                                    tt.removeAt(index);
                                  });
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.add_circle_outline_sharp),
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await acceptORreject(
                                      decision: "true", TM: FTP, index: index);
                                  setState(() {
                                    ff.add(tt[index]);
                                    tt.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );

    Widget SendRequests = Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: departmentController,
              decoration: InputDecoration(
                labelText: "Enter the Department Name",
                fillColor: Color.fromARGB(255, 255, 255, 255),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('Select Date :'),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    selectDate(context);
                  },
                  child: Text('Pick a date'),
                ),
                Text("$selectedDateSS - $selectedWeekdaySS"),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            DropdownButtonFormField<String>(
              value: _selectedPeriod,
              onChanged: (newValue) {
                setState(() {
                  _selectedPeriod = newValue!;
                });
              },
              items: _periods.map((department) {
                return DropdownMenuItem<String>(
                  value: department,
                  child: Text(department),
                );
              }).toList(),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      if (checked(timeTable: FTP)) {
                        getKali();
                      } else {
                        showSnackBar(context,
                            "you dont have period for the selected time");
                      }
                    },
                    child: Text("search"))),
            fetchInit
                ? Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : fetched
                    ? dumm.isEmpty
                        ? Center(
                            child: Text("No faculty are free"),
                          )
                        : Column(
                            children: [
                              DropdownButtonFormField<SubstituteModelFORDROP>(
                                value: _selectedFaculty,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedFaculty = newValue!;
                                  });
                                },
                                items: dumm
                                    .map((SubstituteModelFORDROP department) {
                                  return DropdownMenuItem<
                                      SubstituteModelFORDROP>(
                                    value: department,
                                    child: Text(
                                        "${department.FacultyName}-${department.FacultyId}"),
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  sendRequiest();
                                },
                                child: Text("Send Request"),
                              ),
                            ],
                          )
                    : Text("Select date and search to get results"),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Substitute Page"),
        bottom: TabBar(
          // isScrollable: true,
          controller: _controller,
          indicatorColor: const Color.fromARGB(255, 251, 171, 58),
          tabs: [
            Tab(
              text: "Send Requests",
            ),
            Tab(
              text: "Substitutes",
            ),
            Tab(
              text: "Requests",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          SendRequests,
          substitutes,
          AcceptRequest,
        ],
      ),
    );
  }
}





















// Container(
//                         child: Column(
//                           children: [
//                             Text(
//                                 "${tt[index].Date} ${tt[index].Department}-${tt[index].Section} ${index}"),
//                             Row(
//                               children: [
//                                 ElevatedButton(
//                                   onPressed: () async {
//                                     setState(() {
//                                       _isLoading = true;
//                                     });
//                                     await acceptORreject(
//                                         decision: "false",
//                                         TM: FTP,
//                                         index: index);
//                                     setState(() {
//                                       tt.removeAt(index);
//                                     });
//                                   },
//                                   child: Text("Cancel"),
//                                 ),
//                                 ElevatedButton(
//                                   onPressed: () async {
//                                     setState(() {
//                                       _isLoading = true;
//                                     });
//                                     await acceptORreject(
//                                         decision: "true",
//                                         TM: FTP,
//                                         index: index);
//                                     setState(() {
//                                       ff.add(tt[index]);
//                                       tt.removeAt(index);
//                                     });
//                                   },
//                                   child: Text("accept"),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),