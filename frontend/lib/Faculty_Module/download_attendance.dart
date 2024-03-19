import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/ip.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadAttendanceScreen extends StatefulWidget {
  const DownloadAttendanceScreen({Key? key}) : super(key: key);

  @override
  State<DownloadAttendanceScreen> createState() =>
      _DownloadAttendanceScreenState();
}

class _DownloadAttendanceScreenState extends State<DownloadAttendanceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  String? pdfPath11;
  String fileUrl = '';
  String savename = '';

  late TextEditingController _regulationController;
  late TextEditingController _departmentController;
  late TextEditingController _sectionController;
  late TextEditingController _regulationController1;
  late TextEditingController _departmentController1;
  late TextEditingController _sectionController1;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;

  bool isfetching = false;
  bool isfetched = false;
  bool isdownloaded = false;
  bool isdownloading = false;
  bool iserror = false;

  double progress = 0.00;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
    _regulationController = TextEditingController();
    _departmentController = TextEditingController();
    _sectionController = TextEditingController();
    _regulationController1 = TextEditingController();
    _departmentController1 = TextEditingController();
    _sectionController1 = TextEditingController();
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _regulationController.dispose();
    _departmentController.dispose();
    _sectionController.dispose();
    _regulationController1.dispose();
    _departmentController1.dispose();
    _sectionController1.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  void openPdf() {
    try {
      OpenFile.open(pdfPath11);
      setState(() {
        isdownloaded = false;
        isfetching = false;
        isfetched = false;
        isdownloaded = false;
      });
    } catch (error) {
      print('Error opening PDF: $error');
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _startDateController) {
      setState(() {
        _startDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _endDateController) {
      setState(() {
        _endDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void getDayWiseAttendance() async {
    setState(() {
      isfetching = true;
    });
    try {
      var response = await http.post(
        Uri.parse(
            '${ip}/api/attendanceHistory/downloadAttendance?regulation=${_regulationController.text.toUpperCase()}&department=${_departmentController.text.toUpperCase()}&section=${_sectionController.text.toUpperCase()}'),
        body: jsonEncode({
          "startDate": _startDateController.text,
          "endDate": _endDateController.text,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        var result = jsonDecode(response.body);
        setState(() {
          savename = result["AttendanceExcelName"];
          fileUrl = result["AttendanceExcelUrl"];
          isfetching = false;
          isfetched = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void getSubjectWiseAttendance() async {
    setState(() {
      if (isfetched) {
        isfetched = false;
      }
      isfetching = true;
    });
    try {
      var response = await http.get(
        Uri.parse(
            '${ip}/api/attendanceHistory/downloadSubjectWiseAttendance?regulation=${_regulationController1.text.toUpperCase()}&department=${_departmentController1.text.toUpperCase()}&section=${_sectionController1.text.toUpperCase()}'),
      );
      if (response.statusCode == 200) {
        print(response.body);
        var result = jsonDecode(response.body);
        setState(() {
          savename = result["AttendanceExcelName"];
          fileUrl = result["AttendanceExcelUrl"];
          isfetching = false;
          isfetched = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void downloadExcel() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      //private storage -------> var dir = await getApplicationDocumentsDirectory(); <-------
      var dir = await getExternalStorageDirectory();
      if (dir != null) {
        // String savename = savename;
        String savePath = dir.path + "/$savename";
        setState(() {
          pdfPath11 = savePath;
        });
        print(savePath);

        //output:  /storage/emulated/0/Android/data/com.example.frontend/files/next.pdf

        try {
          setState(() {
            if (isdownloaded) {
              isdownloaded = false;
            }
            isdownloading = true;
          });

          await Dio().download(fileUrl, savePath,
              onReceiveProgress: (received, total) {
            if (total != -1) {
              setState(() {
                progress = received / total;
                print(progress);
              }); // For progress indicaton
            }
          });

          setState(() {
            isdownloading = false;
            isdownloaded = true;
          });
          print("File is saved to download folder.");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("File Downloaded"),
          ));
        } on DioException catch (e) {
          print(e.message);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download Attendance"),
        bottom: TabBar(
          controller: _controller,
          indicatorColor: const Color.fromARGB(255, 251, 171, 58),
          tabs: [
            Tab(
              text: "Day wise Attendance",
            ),
            Tab(
              text: "Subject wise Attendance",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _regulationController,
                      decoration: InputDecoration(
                        labelText: 'Regulation',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter regulation';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _departmentController,
                      decoration: InputDecoration(
                        labelText: 'Department',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter department';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _sectionController,
                      decoration: InputDecoration(
                        labelText: 'Section',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter section';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _startDateController,
                            decoration: InputDecoration(
                              labelText: 'Start date',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter start date';
                              }
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () => _selectStartDate(context),
                          icon: Icon(Icons.calendar_today),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: _endDateController,
                            decoration: InputDecoration(
                              labelText: 'End date',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter end date';
                              }
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () => _selectEndDate(context),
                          icon: Icon(Icons.calendar_today),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Process the form data
                            String regulation = _regulationController.text;
                            String department = _departmentController.text;
                            String section = _sectionController.text;
                            String startDate = _startDateController.text;
                            String endDate = _endDateController.text;

                            // You can use regulation, department, section, startDate, and endDate as needed
                            print('Regulation: $regulation');
                            print('Department: $department');
                            print('Section: $section');
                            print('Start Date: $startDate');
                            print('End Date: $endDate');

                            if (isdownloaded) {
                              openPdf();
                            } else {
                              if (isfetched) {
                                downloadExcel();
                              } else {
                                getDayWiseAttendance();
                              }
                            }
                          }
                        },
                        child: isfetching
                            ? CircularProgressIndicator()
                            : isfetched
                                ? isdownloading
                                    ? CircularProgressIndicator.adaptive()
                                    : isdownloaded
                                        ? Text("Open")
                                        : Text("Download")
                                : Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Placeholder for Subject wise Attendance
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _regulationController1,
                    decoration: InputDecoration(
                      labelText: 'Regulation',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter regulation';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _departmentController1,
                    decoration: InputDecoration(
                      labelText: 'Department',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter department';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _sectionController1,
                    decoration: InputDecoration(
                      labelText: 'Section',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter section';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey1.currentState!.validate()) {
                          // Process the form data
                          String regulation = _regulationController1.text;
                          String department = _departmentController1.text;
                          String section = _sectionController1.text;
                          // You can use regulation, department, section, startDate, and endDate as needed
                          print('Regulation: $regulation');
                          print('Department: $department');
                          print('Section: $section');
                        }
                        if (isdownloaded) {
                          openPdf();
                        } else {
                          if (isfetched) {
                            downloadExcel();
                          } else {
                            getSubjectWiseAttendance();
                          }
                        }
                      },
                      child: isfetching
                          ? CircularProgressIndicator.adaptive()
                          : isfetched
                              ? isdownloading
                                  ? CircularProgressIndicator.adaptive()
                                  : isdownloaded
                                      ? Text("Open")
                                      : Text("Download")
                              : Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
