import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/services/ip.dart';
import 'package:http/http.dart' as http;

class HostelAddSpecialRoomScreen extends StatefulWidget {
  const HostelAddSpecialRoomScreen({Key? key}) : super(key: key);

  @override
  State<HostelAddSpecialRoomScreen> createState() =>
      _HostelAddSpecialRoomScreenState();
}

class _HostelAddSpecialRoomScreenState
    extends State<HostelAddSpecialRoomScreen> {
  List<int> rooms = [];
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _floorNoController = TextEditingController();
  final TextEditingController _noOfRoomsController = TextEditingController();
  final TextEditingController _bedsPerRoomController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _typeController.dispose();
    _floorNoController.dispose();
    _noOfRoomsController.dispose();
    _bedsPerRoomController.dispose();
    super.dispose();
  }

  void createRooms() async {
    print(jsonEncode({
      "type": _typeController.text,
      "floorno": int.parse(_floorNoController.text),
      "roomsarr": rooms,
      "noofbedsperroom": int.parse(_bedsPerRoomController.text)
    }));
    var response =
        await http.post(Uri.parse("${ip}/api/hostels/createSpecialRooms"),
            body: jsonEncode({
              "type": _typeController.text,
              "floorno": int.parse(_floorNoController.text),
              "roomsarr": rooms,
              "noofbedsperroom": int.parse(_bedsPerRoomController.text)
            }),
            headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Success"),
          content: const Text("Rooms have been succesfully added"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        ),
      );
    } else if (response.statusCode == 232) {
      // String message = jsonDecode(response.body)['message'];
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Warning"),
          content: const Text("floor already present add in special rooms"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Failed"),
          content: const Text("Something went wrong"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add special hostel'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _typeController,
                  decoration: InputDecoration(labelText: 'Type'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter type';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _floorNoController,
                  decoration: InputDecoration(labelText: 'Floor No'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter floor number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _bedsPerRoomController,
                  decoration: InputDecoration(labelText: 'Beds per Room'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter beds per room';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _noOfRoomsController,
                        decoration: InputDecoration(labelText: 'Room no'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        rooms.add(int.parse(_noOfRoomsController.text));
                        _noOfRoomsController.clear();
                      },
                      child: Text("Add"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width - 50,
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 30,
                        childAspectRatio: 1,
                      ),
                      itemCount: rooms.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () {
                            setState(() {
                              rooms.removeAt(index);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green
                                    .shade300, // This should be replaced with the real progress percentage
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            height: 80,
                            width: 80,
                            child: Center(
                              child: Text(
                                rooms[index].toString(),
                                style: TextStyle(fontSize: 25),
                              ), // This should be replaced with the room number
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Process the data

            createRooms();
          }
        },
        child: Text("Next"),
      ),
    );
  }
}
