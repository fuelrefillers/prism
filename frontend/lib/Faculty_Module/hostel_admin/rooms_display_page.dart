import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/services/ip.dart';
import 'package:http/http.dart' as http;

class RoomsDisplayPage extends StatefulWidget {
  final String type;
  final int floorno;
  final int noofrooms;
  final int bedsPerRoom;
  const RoomsDisplayPage(
      {super.key,
      required this.bedsPerRoom,
      required this.floorno,
      required this.noofrooms,
      required this.type});

  @override
  State<RoomsDisplayPage> createState() => _RoomsDisplayPageState();
}

class _RoomsDisplayPageState extends State<RoomsDisplayPage> {
  List<int> rooms = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      rooms = List.generate(
          widget.noofrooms, (index) => widget.floorno * 100 + (index + 1));
    });
  }

  void createRooms() async {
    print(jsonEncode({
      "type": widget.type,
      "floorno": widget.floorno,
      "roomsarr": rooms,
      "noofbedsperroom": widget.bedsPerRoom
    }));
    var response = await http.post(Uri.parse("${ip}/api/hostels/createRooms"),
        body: jsonEncode({
          "type": widget.type,
          "floorno": widget.floorno,
          "roomsarr": rooms,
          "noofbedsperroom": widget.bedsPerRoom
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
        title: Text("rooms"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 80),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: 1,
            ),
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
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
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            createRooms();
          },
          label: Text("Done")),
    );
  }
}
