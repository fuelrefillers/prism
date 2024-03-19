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
        shadowColor: Colors.grey,
        elevation: 1.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Bus Stops"),
            Image.asset(
              'assets/MREC_logo.png',
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width / 8,
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: bus.Stoplocation.length,
        itemBuilder: (context, index) => MultiPurposeLinkCard(
          category: '',
          height1: MediaQuery.of(context).size.height / 12,
          subcategory: '',
          subcategory1: bus.Stoplocation[index],
        ),
      ),
    );
  }
}
