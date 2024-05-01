import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/hostel_admin/to_be_changed/rooms.dart';
import 'package:frontend/models/hostel_models.dart';
import 'package:frontend/services/ip.dart';
import 'package:frontend/widgets/linear_progress_bar.dart';

class Floors extends StatefulWidget {
  final String type;
  const Floors({super.key, required this.type});

  @override
  State<Floors> createState() => _FloorsState();
}

class _FloorsState extends State<Floors> {
  List<HostelFloorsModel> floors = [];
  bool isError = false;

  @override
  void initState() {
    super.initState();
    getFloorsData();
  }

  void getFloorsData() async {
    List<HostelFloorsModel> temp = [];
    var response = await http
        .get(Uri.parse("${ip}/api/hostels/getfloors?type=${widget.type}"));
    if (response.statusCode == 200) {
      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        HostelFloorsModel post =
            HostelFloorsModel.fromMap(result[i] as Map<String, dynamic>);
        temp.add(post);
      }

      setState(() {
        temp.sort((a, b) => a.floorNumber.compareTo(b.floorNumber));
        floors = temp;
      });
    } else {
      setState(() {
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Floor Selection'),
      ),
      body: floors.isEmpty && isError == false
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : isError
              ? Center(
                  child: Text(
                      "Something went wrong or resultrs aren't updated yet !!!"),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: floors.length,
                    itemBuilder: (context, index) => buildContainer(context,
                        floor: floors[index].floorNumber,
                        totalBeds: floors[index].totalBeds,
                        bedsRemaining: floors[index].availableBeds),
                  ),
                ),
    );
  }

  Widget buildContainer(BuildContext context,
      {required int floor,
      required int totalBeds,
      required int bedsRemaining}) {
    double progressPercentage = bedsRemaining / totalBeds;
    Color progressBarColor = calculateProgressBarColor(progressPercentage);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Rooms(floorno: floor, type: widget.type)));
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 254, 254, 254),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.bed, size: 30.0),
                    SizedBox(width: 12.0),
                    Text(
                      "${bedsRemaining.toString()}",
                      style: TextStyle(fontSize: 24.0),
                    ),
                    Text(
                      "free out of ${totalBeds.toString()}",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                          color: Color.fromARGB(255, 107, 107, 107)),
                    ),
                  ],
                ),
                Text(
                  'FLOOR $floor',
                  style: TextStyle(fontSize: 24.0),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            LinearProgressBar(
              progressPer: progressPercentage,
              barcolor: progressBarColor,
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
