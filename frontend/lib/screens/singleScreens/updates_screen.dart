import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/updates_model.dart';
import 'package:frontend/screens/singleScreens/Updates_viewer_screen.dart';
import 'package:frontend/services/ip.dart';
import 'package:http/http.dart' as http;

class UpdatesViewScreen extends StatefulWidget {
  const UpdatesViewScreen(
      {super.key,
      required this.department,
      required this.regulation,
      required this.section});
  final String department;
  final String regulation;
  final String section;

  @override
  State<UpdatesViewScreen> createState() => _UpdatesViewScreenState();
}

class _UpdatesViewScreenState extends State<UpdatesViewScreen> {
  List<UpdatesModel> upm = [];

  @override
  void initState() {
    super.initState();
    getUpdates();
  }

  void getUpdates() async {
    try {
      var Response = await http.get(Uri.parse(
          "${ip}/api/updates/getUpdates?regulation=${widget.regulation}&department=${widget.department}&section=${widget.section}"));

      if (Response.statusCode == 200) {
        List<UpdatesModel> temp = [];
        var result = jsonDecode(Response.body);
        print(result);
        for (int i = 0; i < result.length; i++) {
          UpdatesModel s =
              UpdatesModel.fromMap(result[i] as Map<String, dynamic>);
          temp.add(s);
        }
        setState(() {
          upm = temp;
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
        title: Text("Updates"),
      ),
      body: ListView.builder(
          itemCount: upm.length,
          itemBuilder: (context, index) => ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdatesViewerScreen(
                        update: upm[index],
                      ),
                    ),
                  );
                },
                leading: Container(
                  width: 50,
                  height: 70,
                  child: Image.asset(
                    'assets/MREC_logo.png',
                  ),
                ),
                title: Text(upm[index].SentBy),
                subtitle: Text(upm[index].Title),
              )),
    );
  }
}
