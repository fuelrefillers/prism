import 'dart:convert';
import 'package:frontend/services/ip.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class NewFacultyOrChangeClassesScreen extends StatefulWidget {
  const NewFacultyOrChangeClassesScreen({super.key});

  @override
  State<NewFacultyOrChangeClassesScreen> createState() =>
      _NewFacultyOrChangeClassesScreenState();
}

class _NewFacultyOrChangeClassesScreenState
    extends State<NewFacultyOrChangeClassesScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _facultyIdController = TextEditingController();
  TextEditingController _facultyNameController = TextEditingController();
  TextEditingController _facultyDesignationController = TextEditingController();
  TextEditingController _facultyPhnNoController = TextEditingController();
  TextEditingController _facultyDepartmentController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isAdmin = false; // Added isAdmin state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faculty Data Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _facultyIdController,
                decoration: InputDecoration(labelText: 'Faculty ID'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Faculty ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _facultyNameController,
                decoration: InputDecoration(labelText: 'Faculty Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Faculty Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _facultyDesignationController,
                decoration: InputDecoration(labelText: 'Faculty Designation'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Faculty Designation';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _facultyDepartmentController,
                decoration: InputDecoration(labelText: 'Faculty Department'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Faculty Department';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _facultyPhnNoController,
                decoration: InputDecoration(labelText: 'Faculty PhnNo'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Faculty PhnNo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter User name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Password';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Text('Is Admin?'),
                  Radio(
                    value: true,
                    groupValue: _isAdmin,
                    onChanged: (value) {
                      setState(() {
                        _isAdmin = value!;
                      });
                    },
                  ),
                  Text('Yes'),
                  Radio(
                    value: false,
                    groupValue: _isAdmin,
                    onChanged: (value) {
                      setState(() {
                        _isAdmin = value!;
                      });
                    },
                  ),
                  Text('No'),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, send data to server
                    sendDataToServer();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendDataToServer() async {
    final url = '${ip}/api/faculty/create';
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "FacultyId": _facultyIdController.text,
      "FacultyName": _facultyNameController.text,
      "FacultyDesignation": _facultyDesignationController.text,
      "FacultyPhnNo": _facultyPhnNoController.text,
      "FacultyDepartment": _facultyDepartmentController.text,
      "IsAdmin": _isAdmin, // Use the selected value of isAdmin
      "UserName": _usernameController.text,
      "Password": _passwordController.text,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // Data sent successfully
      print('Data sent successfully');
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Conformation"),
          content: const Text("submited"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _passwordController.clear();
                  _usernameController.clear();
                  _facultyDepartmentController.clear();
                  _facultyDesignationController.clear();
                  _facultyIdController.clear();
                  _facultyNameController.clear();
                  _facultyPhnNoController.clear();
                  _isAdmin = false;
                });
                Navigator.pop(context);
              },
              child: const Text("Okay"),
            ),
          ],
        ),
      );
    } else {
      // Error occurred while sending data
      print('Error occurred while sending data: ${response.statusCode}');
    }
  }
}
