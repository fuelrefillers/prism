import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/hostel_models.dart';
import 'package:frontend/providers/hostel_provider.dart';
import 'package:frontend/screens/Hostel_Screens/hostel_booking_confirmation_screen.dart';
import 'package:frontend/services/ip.dart';
import 'package:frontend/util/util.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HostelBedsScreen extends StatefulWidget {
  final List<HostelBedsModel> beds;
  final int roomno;
  final String type;
  final int floorno;

  const HostelBedsScreen(
      {super.key,
      required this.beds,
      required this.roomno,
      required this.type,
      required this.floorno});

  @override
  State<HostelBedsScreen> createState() => _HostelBedsScreenState();
}

class _HostelBedsScreenState extends State<HostelBedsScreen> {
  int selectedBedNo = 0;
  String id = "";
  String name = "";
  bool isSubmiting = false;

  void bookHostelBed() async {
    print("hheeeeelllooooooo");
    isSubmiting = true;
    var response = await http.post(
      Uri.parse(
          "${ip}/api/hostels/bookroom?type=${widget.type}&roomno=${widget.roomno}&floorno=${widget.floorno}"),
      body: jsonEncode(
          {"bedno": selectedBedNo, "bookedBy": name, "bookedById": id}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      isSubmiting = false;
      final data = response.body;

      UserAlreadyExistsModel temp = UserAlreadyExistsModel.fromJson(data);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HostelBookingConfirmationScreen(
                    bookingDetails: temp,
                    inside: "Bed booked Successfully",
                  )));
    } else {
      isSubmiting = false;
      showSnackBar(context, "Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    final hostelstu =
        Provider.of<HostelProvider>(context, listen: false).hostelStudent;

    return Scaffold(
      appBar: AppBar(
        title: Text("Room No : ${widget.roomno.toString()}"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "select a bed you want to book",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    childAspectRatio: 4 / 2,
                  ),
                  itemCount: widget.beds.length,
                  itemBuilder: (context, index) {
                    bool isBooked = widget.beds[index]
                        .isBooked; // Add this variable to track selection state

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          // Toggle selection state
                          if (selectedBedNo == widget.beds[index].bedNumber) {
                            selectedBedNo = 0;
                          } else {
                            selectedBedNo = widget.beds[index].bedNumber;
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedBedNo == widget.beds[index].bedNumber
                              ? Color.fromARGB(255, 117, 151,
                                  157) // Light orange color for selected
                              : isBooked
                                  ? Color.fromARGB(255, 17, 79,
                                      90) // White background if booked
                                  : Colors
                                      .transparent, // Transparent if not booked
                          border: Border.all(
                            color: selectedBedNo == widget.beds[index].bedNumber
                                ? Color.fromARGB(255, 117, 151,
                                    157) // Light orange color for selected
                                : isBooked
                                    ? Color.fromARGB(255, 17, 79, 90)
                                    : Color.fromARGB(255, 53, 139,
                                        154), // Border color based on booked status
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 30,
                        width: 30,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.bed,
                                size: 40,
                                color: selectedBedNo ==
                                        widget.beds[index].bedNumber
                                    ? const Color.fromARGB(255, 255, 255,
                                        255) // Light orange color for selected
                                    : isBooked
                                        ? Color.fromARGB(255, 255, 255,
                                            255) // White background if booked
                                        : Color.fromARGB(255, 0, 0,
                                            0), // Icon color based on selection
                              ),
                              Text(
                                widget.beds[index].bedNumber.toString(),
                                style: TextStyle(
                                  fontSize: 30,
                                  color: selectedBedNo ==
                                          widget.beds[index].bedNumber
                                      ? const Color.fromARGB(255, 255, 255,
                                          255) // Light orange color for selected
                                      : isBooked
                                          ? Color.fromARGB(255, 255, 255,
                                              255) // White background if booked
                                          : Color.fromARGB(255, 0, 0, 0),
                                ), // Text color based on selection
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 53, 139,
                            154), // This should be replaced with the real progress percentage
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
                  SizedBox(
                    width: 3,
                  ),
                  Text("Available"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 117, 151, 157),
                      border: Border.all(
                        color: Color.fromARGB(255, 117, 151,
                            157), // This should be replaced with the real progress percentage
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
                  SizedBox(
                    width: 3,
                  ),
                  Text("Choosen"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 17, 79, 90),
                      border: Border.all(
                        color: Color.fromARGB(255, 17, 79,
                            90), // This should be replaced with the real progress percentage
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
                  SizedBox(
                    width: 3,
                  ),
                  Text("Occupied"),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 17, 79, 90)),
            ),
            onPressed: () {
              setState(() {
                id = hostelstu.Id;
                name = hostelstu.name;
              });
              if (selectedBedNo != 0) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Confirm Your Data"),
                    content: Container(
                      height: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Name : ${name}",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "Id : ${id}",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "Hostel : ${widget.type} Hostel",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "Floor  No : ${widget.floorno}",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "Room No : ${widget.roomno}",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "Bed No : ${selectedBedNo}",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("cancel"),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            bookHostelBed();
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             HostelBookingConfirmationScreen(bookingDetails: widget)));
                            // Navigator.pop(context);
                          },
                          child: Text("Ok"))
                    ],
                  ),
                );
              } else {
                showSnackBar(context, "Please select a room to proceed");
              }
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: isSubmiting
                  ? Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Text(
                      "Confirm Booking",
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}



      // body: TextButton.icon(
      //   icon: Icon(
      //     Icons.king_bed,
      //     size: 42.0,
      //   ),
      //   label: Text(
      //     'bedNumber',
      //     style: TextStyle(fontSize: 24.0),
      //   ),
      //   onPressed: () {},
      //   style: TextButton.styleFrom(
      //     foregroundColor: Colors.white,
      //     backgroundColor: Colors.green,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(12.0),
      //     ),
      //     minimumSize: Size(120, 80),
      //   ),
      // ),