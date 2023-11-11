import 'package:flutter/material.dart';
import 'package:frontend/widgets/bus_driver_details_card.dart';
import 'package:frontend/widgets/multi_purpose_card.dart';

class BusScreenDetails extends StatelessWidget {
  const BusScreenDetails({super.key});
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
                image: AssetImage('assets/home-screen-hero.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          BusDriverDetailsCard(),
          MultiPurposeCard(category: "Live Location"),
          MultiPurposeCard(category: "Raise complaint"),
        ],
      ),
    );
  }
}
