import 'package:flutter/material.dart';
import 'package:frontend/screens/bus_stops_screen.dart';
import 'package:frontend/screens/raise_complaint.dart';
import 'package:frontend/screens/transport_screen.dart';
import 'package:frontend/widgets/bus_driver_details_card.dart';
import 'package:frontend/widgets/multi_purpose_card.dart';
import 'package:frontend/widgets/multipurpose_link_card.dart';

class BusScreenDetails extends StatelessWidget {
  const BusScreenDetails({super.key, required this.bus});
  final Bus bus;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("route no"),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(79, 135, 135, 135),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(
                    0,
                    10,
                  ),
                ),
              ],
              image: DecorationImage(
                image: AssetImage('assets/bus-hero.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          BusDriverDetailsCard(bus: bus),
          // MultiPurposeCard(category: "Live Location", height1: 80),

          MultiPurposeLinkCard(category: "Live Location", height1: 80),
          MultiPurposeCard(
            category: "Bus Stops",
            height1: 80,
            screen: BusStopsScreen(bus: bus),
          ),
          MultiPurposeCard(
            category: "Raise complaint",
            height1: 80,
            screen: RaiseComplaintScreen(),
          ),
        ],
      ),
    );
  }
}
