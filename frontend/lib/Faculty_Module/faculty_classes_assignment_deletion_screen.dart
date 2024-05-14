// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/faculty_class_manuplaion_screen.dart';
import 'package:frontend/services/ip.dart';
import 'package:http/http.dart' as http;

class FacultyShort {
  String FacultyId;
  String FacultyName;
  String FacultyDepartment;
  FacultyShort({
    required this.FacultyId,
    required this.FacultyName,
    required this.FacultyDepartment,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'FacultyId': FacultyId,
      'FacultyName': FacultyName,
      'FacultyDepartment': FacultyDepartment,
    };
  }

  factory FacultyShort.fromMap(Map<String, dynamic> map) {
    return FacultyShort(
      FacultyId: map['FacultyId'] as String,
      FacultyName: map['FacultyName'] as String,
      FacultyDepartment: map['FacultyDepartment'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FacultyShort.fromJson(String source) =>
      FacultyShort.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FacultyClassAssignmentOrdeletionScreen extends StatefulWidget {
  const FacultyClassAssignmentOrdeletionScreen({super.key});

  @override
  State<FacultyClassAssignmentOrdeletionScreen> createState() =>
      _FacultyClassAssignmentOrdeletionScreenState();
}

class _FacultyClassAssignmentOrdeletionScreenState
    extends State<FacultyClassAssignmentOrdeletionScreen> {
  final TextEditingController departmentController = TextEditingController();
  List<FacultyShort> faculties = [];

  void searchbydept() async {
    try {
      print("hello");
      http.Response res = await http.get(Uri.parse(
          '${ip}/api/faculty/getfacultybydeptshort?facultyDepartment=${departmentController.text}'));
      if (res.statusCode == 200) {
        List<FacultyShort> temp = [];
        print(res.body);
        final result = jsonDecode(res.body);
        for (int i = 0; i < result.length; i++) {
          FacultyShort s =
              FacultyShort.fromMap(result[i] as Map<String, dynamic>);
          temp.add(s);
        }
        setState(() {
          faculties = temp;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("changing"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: departmentController,
              decoration: InputDecoration(
                labelText: "Enter the Department Name",
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 17, 79, 90),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              searchbydept();
            },
            child: Text(
              "search",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 17, 79, 90)),
          ),
          SizedBox(
            height: 20,
          ),
          faculties.isEmpty
              ? Text("Search to get list")
              : Expanded(
                  child: ListView.builder(
                    itemCount: faculties.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FacultyClassManuplationScreen(
                                      FacultyId: faculties[index].FacultyId),
                            ),
                          );
                        },
                        title: Text(faculties[index].FacultyName),
                        subtitle: Text(faculties[index].FacultyId),
                        trailing: Text(faculties[index].FacultyDepartment),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
