import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/hostel_admin/to_be_changed/details.dart';
import 'package:frontend/models/hostel_models.dart';

class Beds extends StatefulWidget {
  final List<HostelBedsModel> beds;
  final int roomno;
  const Beds({super.key, required this.beds, required this.roomno});

  @override
  State<Beds> createState() => _BedsState();
}

class _BedsState extends State<Beds> {
  @override
  Widget build(BuildContext context) {
    int selectedBedNo = 0;

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
                      onTap: () {},
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Details(beds: widget.beds)));
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                "More details",
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
