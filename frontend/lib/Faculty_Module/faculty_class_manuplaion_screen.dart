import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/classes_model.dart';
import 'package:frontend/models/faculty_model.dart';
import 'package:frontend/services/ip.dart';
import 'package:http/http.dart' as http;

class FacultyClassManuplationScreen extends StatefulWidget {
  const FacultyClassManuplationScreen({super.key, required this.FacultyId});
  final String FacultyId;
  @override
  State<FacultyClassManuplationScreen> createState() =>
      _FacultyClassManuplationScreenState();
}

class _FacultyClassManuplationScreenState
    extends State<FacultyClassManuplationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool submited = false;
  TextEditingController _DepartmentController = TextEditingController();
  TextEditingController _RegulationController = TextEditingController();
  TextEditingController _SectionController = TextEditingController();
  TextEditingController _YearController = TextEditingController();
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
  @override
  void initState() {
    getFaculty();
    super.initState();
  }

  void addAclass() {
    ClassesModel newt = ClassesModel(
        // Subject: "dd",
        // SubjectCode: "66",
        Department: _DepartmentController.text.toUpperCase(),
        Section: _SectionController.text.toUpperCase(),
        Regulation: _RegulationController.text.toUpperCase(),
        Year: _YearController.text.toUpperCase());
    setState(() {
      faculty.Classes.add(newt);
    });
  }

  void getFaculty() async {
    try {
      http.Response res = await http.post(
        Uri.parse("${ip}/api/faculty/getfacultybyId"),
        body: jsonEncode({"Id": widget.FacultyId}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        print(res.body);
        Faculty F = Faculty.fromJson(res.body);
        setState(() {
          faculty = F;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void showoff(BuildContext context) {
    setState(() {
      if (submited) {
        submited = false;
      }
    });
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Conformation"),
        content: isLoading
            ? Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : Text("wanna delete"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("cancel"),
          ),
          TextButton(
            onPressed: () {
              updateFacultyClasses();
              Future.delayed(Duration(seconds: 1));
              setState(() {
                isLoading = true;
              });

              Navigator.pop(context);
            },
            child: const Text("Okay"),
          ),
        ],
      ),
    );
  }

  void updateFacultyClasses() async {
    String jsonFaculty = faculty.toJson();

    var response = await http.post(
      Uri.parse('${ip}/api/faculty/updateFaculty'),
      body: jsonFaculty,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
        submited = true;
      });
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manuplation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name : ${faculty.FacultyName}"),
            Text("Department : ${faculty.FacultyDepartment}"),
            Text("Faculty Id : ${faculty.FacultyId}"),
            Text("Phn.No : ${faculty.FacultyPhnNo}"),
            Expanded(
              child: ListView.builder(
                itemCount: faculty.Classes.length,
                itemBuilder: (context, index) => ListTile(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Conformation"),
                        content: const Text("wanna delete"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                faculty.Classes.removeAt(index);
                              });
                              Navigator.pop(context);
                            },
                            child: const Text("Okay"),
                          ),
                        ],
                      ),
                    );
                  },
                  shape: Border.all(),
                  title: Center(
                    child: Text(
                        "${faculty.Classes[index].Department}-${faculty.Classes[index].Section}      ${faculty.Classes[index].Regulation}  Year - ${faculty.Classes[index].Year}"),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showoff(context);
              },
              child: Text("submit"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog.fullscreen(
              child: Scaffold(
                appBar: AppBar(
                  title: Text("Add class"),
                ),
                body: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        TextFormField(
                          controller: _DepartmentController,
                          decoration: InputDecoration(labelText: 'Department'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Faculty Department';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _RegulationController,
                          decoration: InputDecoration(labelText: 'Regulation'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Regulation';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _SectionController,
                          decoration: InputDecoration(labelText: 'Section'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Section';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _YearController,
                          decoration: InputDecoration(labelText: 'Year'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Faculty Year';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, send data to server
                              addAclass();
                              setState(() {
                                _DepartmentController.clear();
                                _RegulationController.clear();
                                _SectionController.clear();
                                _YearController.clear();
                              });
                              Navigator.pop(context);
                            }
                          },
                          child: Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
