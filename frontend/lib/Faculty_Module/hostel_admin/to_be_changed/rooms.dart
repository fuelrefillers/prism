import 'dart:convert';
import 'package:frontend/Faculty_Module/hostel_admin/to_be_changed/beds.dart';
import 'package:frontend/services/ip.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:frontend/models/hostel_models.dart';

class Rooms extends StatefulWidget {
  final int floorno;
  final String type;
  const Rooms({super.key, required this.floorno, required this.type});

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  List<HostelsRoomModel> rooms = [];
  bool isError = false;

  @override
  void initState() {
    super.initState();
    getRooms();
  }

  void getRooms() async {
    try {
      List<HostelsRoomModel> temp = [];
      var response = await http.get(Uri.parse(
          "${ip}/api/hostels/getroomsforfloor?type=${widget.type}&floorno=${widget.floorno}"));

      if (response.statusCode == 200) {
        List result = jsonDecode(response.body);
        for (int i = 0; i < result.length; i++) {
          HostelsRoomModel post =
              HostelsRoomModel.fromMap(result[i] as Map<String, dynamic>);
          temp.add(post);
        }

        print(temp);
        temp.sort((a, b) => a.roomNumber.compareTo(b.roomNumber));
        setState(() {
          rooms = temp;
        });
      } else {
        isError = true;
      }
    } catch (e) {
      print(e);
    }
  }

  Color calculateProgressBarColor(double progressPercentage) {
    if (progressPercentage < 0.5) {
      return Color.fromARGB(255, 249, 15, 15);
    } else if (progressPercentage < 0.8) {
      return Color.fromARGB(255, 147, 97, 0);
    } else {
      return Color.fromARGB(255, 0, 147, 59);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Room Selection"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "select a room you want to book",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    childAspectRatio: 1,
                  ),
                  itemCount: rooms.length,
                  itemBuilder: (context, index) {
                    Color x = calculateProgressBarColor(
                        rooms[index].bedsNotBooked / rooms[index].totalBeds);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Beds(
                                      beds: rooms[index].beds,
                                      roomno: rooms[index].roomNumber,
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                x, // This should be replaced with the real progress percentage
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        height: 80,
                        width: 80,
                        child: Center(
                          child: Text(
                            rooms[index].roomNumber.toString(),
                            style: TextStyle(fontSize: 25),
                          ), // This should be replaced with the room number
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 0, 147,
                            59), // This should be replaced with the real progress percentage
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 30,
                    width: 30,
                    child: Center(
                        // This should be replaced with the room number
                        ),
                  ),
                  Text("Available"),
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 147, 97,
                            0), // This should be replaced with the real progress percentage
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 30,
                    width: 30,
                    child: Center(
                        // This should be replaced with the room number
                        ),
                  ),
                  Text("Filling Fast"),
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 249, 15,
                            15), // This should be replaced with the real progress percentage
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 30,
                    width: 30,
                    child: Center(
                        // This should be replaced with the room number
                        ),
                  ),
                  Text("Occupied"),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
