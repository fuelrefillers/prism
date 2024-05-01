import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/mid_details_model.dart';
import 'package:frontend/Faculty_Module/mid_marks_assigning.dart';
import 'package:frontend/providers/faculty_provider.dart';
import 'package:frontend/services/ip.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MidMarksScreen extends StatefulWidget {
  const MidMarksScreen({super.key});

  @override
  State<MidMarksScreen> createState() => _MidMarksScreenState();
}

class _MidMarksScreenState extends State<MidMarksScreen> {
  List<MidDetails> midDetails = [];
  final _formKey1 = GlobalKey<FormState>();
  bool isfetching = false;
  late TextEditingController _regulationController1;
  late TextEditingController _departmentController1;
  late TextEditingController _sectionController1;

  @override
  void initState() {
    _regulationController1 = TextEditingController();
    _departmentController1 = TextEditingController();
    _sectionController1 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _regulationController1.dispose();
    _departmentController1.dispose();
    _sectionController1.dispose();
    super.dispose();
  }

  void fetchMidClasses(String FID) async {
    try {
      setState(() {
        isfetching = true;
      });
      http.Response res = await http.post(
        Uri.parse(
            "${ip}/api/midmarks/getInfo?regulation=${_regulationController1.text.toUpperCase()}&department=${_departmentController1.text.toUpperCase()}&section=${_sectionController1.text.toUpperCase()}"),
        body: jsonEncode({"LecturerId": FID}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        List<MidDetails> temp = [];
        var resut = jsonDecode(res.body);

        for (int i = 0; i < resut.length; i++) {
          MidDetails s = MidDetails.fromMap(resut[i] as Map<String, dynamic>);
          temp.add(s);
        }
        setState(() {
          isfetching = false;
          midDetails = temp;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final faculty =
        Provider.of<FacultyProvider>(context, listen: false).faculty;
    return Scaffold(
      appBar: AppBar(
        title: Text("Mid Marks"),
      ),
      body: Padding(
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
                      fetchMidClasses(faculty.FacultyId);
                    }
                  },
                  child: isfetching
                      ? CircularProgressIndicator.adaptive()
                      : Text('Submit'),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: midDetails.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MidMarksAssigningScreen(
                              midDetails: midDetails[index],
                              FID: faculty.FacultyId),
                        ),
                      );
                    },
                    leading: Text(midDetails[index].Mid),
                    title: Text(
                        "${midDetails[index].Department}-${midDetails[index].Section}-${midDetails[index].Regulation}"),
                    subtitle: Text(
                        "${midDetails[index].SubjectName} - ${midDetails[index].SubjectCode}"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
