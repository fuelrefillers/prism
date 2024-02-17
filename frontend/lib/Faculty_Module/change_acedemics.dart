import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;

class ChangeAcedemicsScreen extends StatefulWidget {
  const ChangeAcedemicsScreen({super.key});

  @override
  State<ChangeAcedemicsScreen> createState() => _ChangeAcedemicsScreen();
}

class _ChangeAcedemicsScreen extends State<ChangeAcedemicsScreen> {
  String _selectedRegulation = 'MR21';
  String _selectedSemester = '1';
  // String _selectedMonth = 'January';
  bool dataFetched = false;
  int _numberOfHolidays = 0;
  int numberOfMonths = 0;
  List<String> regulations = ['MR21', 'MR22', 'MR23'];
  List<String> semesters = ['1', '2', '3'];
  List<String> months = [
    // 'January',
    // 'February',
    // 'March',
    // 'April',
    // 'May',
    // 'June',
    // 'July',
    // 'August',
    // 'September',
    // 'October',
    // 'November',
    // 'December'
  ];

  List<String> generateList(int number) {
    return List<String>.generate(number, (index) => (index + 1).toString());
  }

  Widget set = Center(child: Text("Hello"));

  @override
  Widget build(BuildContext context) {
    if (dataFetched == true) {
      List<String> months = generateList(numberOfMonths);
      String _selectedMonth = '1';
      set = Column(
        children: [
          SizedBox(height: 20.0),
          Text('Select Month:'),
          DropdownButton<String>(
            value: _selectedMonth,
            onChanged: (newValue) {
              setState(() {
                _selectedMonth = newValue!;
              });
            },
            items: months.map((month) {
              return DropdownMenuItem<String>(
                value: month,
                child: Text(month),
              );
            }).toList(),
          ),
          SizedBox(height: 20.0),
          Text('Number of Holidays:'),
          TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _numberOfHolidays = int.tryParse(value) ?? 0;
              });
            },
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              try {
                var response = await http.post(
                  Uri.parse(
                      'http://15.20.17.222:3000/api/semesterdata/update?regulation=MR21&semester=1&month=1'),
                  body: jsonEncode({"intValue": _numberOfHolidays}),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                );
                print(response.statusCode);
                print(jsonDecode(response.body));
              } catch (err) {
                print(err);
              }
            },
            child: Text('Update Holidays'),
          ),
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Holiday Updater'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Select Regulation:'),
            DropdownButton<String>(
              value: _selectedRegulation,
              onChanged: (newValue) {
                setState(() {
                  _selectedRegulation = newValue!;
                });
              },
              items: regulations.map((regulation) {
                return DropdownMenuItem<String>(
                  value: regulation,
                  child: Text(regulation),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text('Select Semester:'),
            DropdownButton<String>(
              value: _selectedSemester,
              onChanged: (newValue) {
                setState(() {
                  _selectedSemester = newValue!;
                });
              },
              items: semesters.map((semester) {
                return DropdownMenuItem<String>(
                  value: semester,
                  child: Text(semester),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  var response = await http.get(Uri.parse(
                      'http://15.20.17.222:3000/api/semesterdata/fetch?regulation=${_selectedRegulation}&semester=${_selectedSemester}'));
                  if (response.statusCode == 200) {
                    setState(() {
                      dataFetched = true;
                      numberOfMonths = jsonDecode(response.body);
                    });
                  }
                  print(jsonDecode(response.body));
                } catch (e) {
                  print(e);
                }
              },
              child: Text('Fetch Data'),
            ),
            set,
          ],
        ),
      ),
    );
  }
}
