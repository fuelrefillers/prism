import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/updates_model.dart';
import 'package:frontend/screens/singleScreens/Updates_viewer_screen.dart';
import 'package:frontend/services/ip.dart';
import 'package:frontend/util/util.dart';
import 'package:http/http.dart' as http;

class DeleteUpdatesScreen extends StatefulWidget {
  final String name;
  final String id;
  const DeleteUpdatesScreen({super.key, required this.id, required this.name});

  @override
  State<DeleteUpdatesScreen> createState() => _DeleteUpdatesScreenState();
}

class _DeleteUpdatesScreenState extends State<DeleteUpdatesScreen> {
  List<UpdatesModel> upm = [];

  @override
  void initState() {
    super.initState();
    getUpdates();
  }

  void getUpdates() async {
    try {
      var Response = await http.post(
        Uri.parse("${ip}/api/updates//getUpdatesForSpecificFaculty"),
        body: jsonEncode({"name": widget.name, "id": widget.id}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

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

  void deleteUpdate(String Id, int index) async {
    var response =
        await http.delete(Uri.parse("${ip}/api/updates/deleteUpdate/${Id}"));

    if (response.statusCode == 200) {
      setState(() {
        upm.removeAt(index);
      });
    } else {
      showSnackBar(context, "Something went wrong");
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
          trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Warning"),
                    content: const Text(
                        "This operation will delete the update permanently"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("cancel"),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            deleteUpdate(upm[index].id, index);
                            Navigator.pop(context);
                          },
                          child: Text("Ok"))
                    ],
                  ),
                );
              },
              icon: Icon(Icons.delete_forever)),
        ),
      ),
    );
  }
}
