import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/review_update.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/ip.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.category});
  final String category;
  @override
  State<MainScreen> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  List<User> data = [];
  List<String> selected = [];

  @override
  void initState() {
    super.initState();
    getRollno();
  }

  void onRollnoSelected(bool? value, rollno) {
    if (value == true) {
      setState(() {
        selected.add(rollno);
      });
    } else {
      setState(() {
        selected.remove(rollno);
      });
    }
  }

  void getRollno() async {
    List<User> res = [];
    try {
      var response = await http.get(Uri.parse(
          'http://$ip:5000/api/userdata/filter?clas=${widget.category}'));
      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        User post = User.fromMap(result[i] as Map<String, dynamic>);
        res.add(post);
      }
      setState(() {
        data = res;
      });
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Faculty"),
      ),
      body: Column(
        children: [
          Container(
            child: Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => CheckboxListTile(
                  shape: CircleBorder(),
                  value: selected.contains(data[index].rollno),
                  onChanged: (bool? value) {
                    onRollnoSelected(value, data[index].rollno);
                  },
                  title: Text(data[index].rollno.toUpperCase()),
                  subtitle: const Text('Supporting text'),
                ),
              ),
            ),
          ),
          // Container(
          //   child: Expanded(
          //     child: ListView.builder(
          //         itemCount: selected.length,
          //         itemBuilder: (context, index) => ElevatedButton(
          //             onPressed: () {}, child: Text(selected[index]))),
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ReviewAndSubmitScreen(selected: selected)));
        },
        label: const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Text("Next"),
        ),
        enableFeedback: true,
      ),
    );
  }
}
