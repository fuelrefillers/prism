import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/hostel_models.dart';
import 'package:frontend/providers/hostel_provider.dart';
import 'package:frontend/screens/Hostel_Screens/hostel_booking_confirmation_screen.dart';
import 'package:frontend/screens/Hostel_Screens/hostel_home_screen.dart';
import 'package:frontend/services/ip.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HostelDetailsScreen extends StatefulWidget {
  const HostelDetailsScreen({super.key});

  @override
  State<HostelDetailsScreen> createState() => _HostelDetailsScreenState();
}

class _HostelDetailsScreenState extends State<HostelDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _admissionIdController = TextEditingController();

  void decideUser() async {
    var response = await http.post(
      Uri.parse("${ip}/api/hostels/isalreadypresent"),
      body: jsonEncode({
        "bookedBy": _nameController.text,
        "bookedById": _admissionIdController.text
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = response.body;
      UserAlreadyExistsModel temp = UserAlreadyExistsModel.fromJson(data);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HostelBookingConfirmationScreen(
                    bookingDetails: temp,
                    inside:
                        "You have an existing booking for the following details",
                  )));
    } else if (response.statusCode == 248) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HostelsHomeScreen()));
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final hostelstu = Provider.of<HostelProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Hostels"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Student Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter student name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _admissionIdController,
                decoration: InputDecoration(
                  labelText: 'Admission ID',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter admission ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process form data
                    String name = _nameController.text;
                    String admissionId = _admissionIdController.text;
                    // You can handle form submission here
                    hostelstu.setHoselStudentFromModel(
                        HostelStudentModel(Id: admissionId, name: name));
                    decideUser();
                    print('Name: $name, Admission ID: $admissionId');
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

  @override
  void dispose() {
    _nameController.dispose();
    _admissionIdController.dispose();
    super.dispose();
  }
}
