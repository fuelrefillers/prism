import 'package:flutter/material.dart';
import 'package:frontend/models/bus_model.dart';

import 'package:frontend/widgets/multipurpose_link_card.dart';

class BusStopsScreen extends StatelessWidget {
  const BusStopsScreen({super.key, required this.bus});
  final Bus bus;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bus Stops"),
      ),
      body: ListView.builder(
        itemCount: bus.Stoplocation.length,
        itemBuilder: (context, index) => MultiPurposeLinkCard(
            category: bus.Stoplocation[index], height1: 80),
      ),
    );
  }
}
