import 'package:flutter/material.dart';
import 'package:frontend/hostels/models/BoysFloors.dart';
import 'package:frontend/hostels/screens/RoomSelection_boys.dart';
import 'package:frontend/hostels/services/FetchingBoys.dart';

class FloorSeclection_boys extends StatefulWidget {
  @override
  State<FloorSeclection_boys> createState() => _FloorSeclection_boysState();
}

class _FloorSeclection_boysState extends State<FloorSeclection_boys> {
  final FetchingBoys dd = FetchingBoys();
  List<BoysFloors> data = [];
  @override
  void initState() {
    super.initState();
    // assignData();
  }

  void assignData() async {
    List<BoysFloors> dummy = await dd.fetchBoysFloorsFromApi();
    setState(() {
      data = dummy;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Floor Selection'),
      ),
      body:
          // data.isEmpty
          //     ? Center(
          //         child: CircularProgressIndicator.adaptive(),
          //       )
          //     :
          Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildContainer(context, floor: 1, bedNumber: 30),
          SizedBox(height: 16.0),
          buildContainer(context, floor: 2, bedNumber: 20),
          SizedBox(height: 16.0),
          buildContainer(context, floor: 3, bedNumber: 35),
          SizedBox(height: 16.0),
          buildContainer(context, floor: 4, bedNumber: 40),
        ],
      ),
    );
  }

  Widget buildContainer(BuildContext context,
      {required int floor, required int bedNumber}) {
    double progressPercentage = bedNumber / 50.0;
    Color progressBarColor = calculateProgressBarColor(progressPercentage);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomSelection_boys(floor: floor),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.king_bed, size: 30.0),
                    SizedBox(width: 12.0),
                    Text(
                      bedNumber.toString(),
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ],
                ),
                Text(
                  'Floor $floor',
                  style: TextStyle(fontSize: 24.0),
                ),
              ],
            ),
            SizedBox(height: 24.0),
            LinearProgressIndicator(
              value: progressPercentage,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(progressBarColor),
              minHeight: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Color calculateProgressBarColor(double progressPercentage) {
    if (progressPercentage < 0.5) {
      return Colors.red;
    } else if (progressPercentage < 0.8) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }
}
