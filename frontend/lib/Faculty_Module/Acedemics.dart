import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AcademicsPage(),
    );
  }
}

class AcademicsPage extends StatefulWidget {
  @override
  _AcademicsPageState createState() => _AcademicsPageState();
}

class _AcademicsPageState extends State<AcademicsPage> {
  int numberOfMonths = 0;

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
              decoration: InputDecoration(labelText: 'Regulation'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Semester'),
            ),
            TextFormField(
              decoration:
                  InputDecoration(labelText: 'Total Working Days for Semester'),
            ),
            TextFormField(
              decoration:
                  InputDecoration(labelText: 'Total Number of Holidays'),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  numberOfMonths = int.tryParse(value) ?? 0;
                });
              },
              decoration: InputDecoration(labelText: 'Number of Months'),
            ),
            if (numberOfMonths > 0) ...generateMonthFields(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text("submit"),
      ),
    );
  }

  List<Widget> generateMonthFields() {
    List<Widget> monthFields = [];
    for (int i = 1; i <= numberOfMonths; i++) {
      monthFields.add(
        TextFormField(
          decoration: InputDecoration(labelText: 'Working Days for Month $i'),
        ),
      );
    }
    return monthFields;
  }
}
