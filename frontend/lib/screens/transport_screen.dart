// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/services/ip.dart';
import 'package:frontend/widgets/bus_card.dart';
import 'package:http/http.dart' as http;

class Bus {
  final String Busno;
  final String Routeno;
  final String Routename;
  final String Routedesc;
  final String drivername;
  final int driverph;
  final String driverimage;
  final String startlocation;
  final String currentlocation;
  final String starttime;
  final String reachtime;
  final List<dynamic> Stoplocation;
  Bus({
    required this.Busno,
    required this.Routeno,
    required this.Routename,
    required this.Routedesc,
    required this.drivername,
    required this.driverph,
    required this.driverimage,
    required this.startlocation,
    required this.currentlocation,
    required this.starttime,
    required this.reachtime,
    required this.Stoplocation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Busno': Busno,
      'Routeno': Routeno,
      'Routename': Routename,
      'Routedesc': Routedesc,
      'drivername': drivername,
      'driverph': driverph,
      'driverimage': driverimage,
      'startlocation': startlocation,
      'currentlocation': currentlocation,
      'starttime': starttime,
      'reachtime': reachtime,
      'Stoplocation': Stoplocation,
    };
  }

  factory Bus.fromMap(Map<String, dynamic> map) {
    return Bus(
      Busno: map['Busno'] as String,
      Routeno: map['Routeno'] as String,
      Routename: map['Routename'] as String,
      Routedesc: map['Routedesc'] as String,
      drivername: map['drivername'] as String,
      driverph: map['driverph'] as int,
      driverimage: map['driverimage'] as String,
      startlocation: map['startlocation'] as String,
      currentlocation: map['currentlocation'] as String,
      starttime: map['starttime'] as String,
      reachtime: map['reachtime'] as String,
      Stoplocation: List<dynamic>.from((map['Stoplocation'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Bus.fromJson(String source) =>
      Bus.fromMap(json.decode(source) as Map<String, dynamic>);
}

// model compleated

class Transportscreen extends StatefulWidget {
  @override
  State<Transportscreen> createState() {
    return _TransportscreenState();
  }
}

class _TransportscreenState extends State<Transportscreen> {
  List<Bus> Busses = [];
  List<Bus> filteredList = [];
  @override
  void initState() {
    super.initState();
    getBusses();
  }

  void getBusses() async {
    List<Bus> books1 = [];
    try {
      var response =
          await http.get(Uri.parse('http://$ip:5000/api/buses/getbuses'));
      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        Bus post = Bus.fromMap(result[i] as Map<String, dynamic>);
        books1.add(post);
      }
      print(books1);
      setState(() {
        Busses = books1;
        filteredList = Busses;
      });
    } catch (err) {
      print(err.toString());
    }
  }

  void search(String searchkey) {
    List<Bus> result = [];

    if (searchkey.isEmpty) {
      result = Busses;
    } else {
      result = Busses.where((bus) =>
              bus.Routename.toLowerCase().contains(searchkey.toLowerCase()))
          .toList();
      print(result.toList());
      print(filteredList);
    }
    setState(() {
      filteredList = result;
    });
    print(filteredList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transport"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => search(value),
              decoration: InputDecoration(
                hintText: 'Search...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {},
                ),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(15.0),

            // ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) => BusCard(
                  bus: filteredList[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
