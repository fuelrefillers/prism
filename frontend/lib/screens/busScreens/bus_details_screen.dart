import 'package:flutter/material.dart';
import 'package:frontend/location/location_recieving.dart';
import 'package:frontend/models/bus_model.dart';
import 'package:frontend/screens/busScreens/bus_stops_screen.dart';
import 'package:frontend/screens/singleScreens/raise_complaint.dart';
import 'package:frontend/widgets/bus_driver_details_card.dart';
import 'package:frontend/widgets/multi_purpose_card.dart';

class BusScreenDetails extends StatelessWidget {
  const BusScreenDetails({super.key, required this.bus});
  final Bus bus;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        shadowColor: Colors.grey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Route details"),
            Image.asset(
              'assets/MREC_logo.png',
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width / 8,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          BusDriverDetailsCard(bus: bus),
          // MultiPurposeCard(category: "Live Location", height1: 80),
          FittedBox(
            fit: BoxFit.fill,
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Route ${bus.Routeno}",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 196, 148, 80),
                          fontWeight: FontWeight.w700),
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    Text(
                      "${bus.Routename} - ${bus.Busno}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 17, 79, 90),
                      ),
                    ),
                    Text(
                      bus.Routedesc,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                            Text(
                              "start time :",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromARGB(255, 0, 0, 0)),
                            ),
                            Text(
                              bus.starttime,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      const Color.fromARGB(255, 25, 86, 136)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.pin_drop_outlined,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                Text(
                                  "start stop :",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                                Text(bus.startlocation,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: const Color.fromARGB(
                                            255, 25, 86, 136))),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          MultiPurposeCard(
            category: "Live Location",
            height1: MediaQuery.of(context).size.height / 12,
            screen: MapScreen(),
            subcategory: '',
            subcategory1: 'Live Location',
          ),
          MultiPurposeCard(
            category: "Bus Stops",
            height1: MediaQuery.of(context).size.height / 12,
            screen: BusStopsScreen(bus: bus),
            subcategory: '',
            subcategory1: 'Bus Stops',
          ),
          MultiPurposeCard(
            category: "Raise complaint",
            height1: MediaQuery.of(context).size.height / 12,
            screen: RaiseComplaintScreen(),
            subcategory: '',
            subcategory1: 'Raise Complaint',
          ),
        ],
      ),
    );
  }
}
