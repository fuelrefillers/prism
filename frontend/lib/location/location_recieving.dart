// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:http/http.dart' as http;
// import 'package:latlong2/latlong.dart';

// class MapScreen extends StatefulWidget {
//   // Replace with your server URL
//   static final String serverUrl =
//       "http://192.168.29.194:3000/api/liveloction/get?busno=6280";

//   @override
//   State<MapScreen> createState() {
//     return _MapScreenState();
//   }
//   // @override
//   // _MapScreen createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   final _updateDuration =
//       Duration(seconds: 1); // Time interval between location updates
//   Timer? _timer;
//   double lat = 0.00;
//   double long = 0.00;

//   @override
//   void initState() {
//     super.initState();
//     _fetchData();
//     _timer = Timer.periodic(_updateDuration, (_) => _fetchData());
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   Future<void> _fetchData() async {
//     try {
//       var response = await http.get(Uri.parse(MapScreen.serverUrl));
//       var data = jsonDecode(response.body);
//       double latitude = data['latitude'];
//       double longitude = data['longitude'];
//       print(latitude);
//       setState(() {
//         lat = latitude;
//         long = longitude;
//       });
//     } catch (e) {
//       print("Error getting location: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             title: Text(' Live Location Tracking'),
//           ),
//           body: Stack(
//             children: [
//               FlutterMap(
//                 options:
//                     MapOptions(initialCenter: LatLng(37.4219983, -122.084)),
//                 children: [
// TileLayer(
//   urlTemplate:
//       'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//   userAgentPackageName: 'com.example.Prism',
// ),
//                   CircleLayer(
//                     circles: [
//                       CircleMarker(
//                         point: LatLng(lat, long), // center of 't Gooi
//                         radius: 5000,
//                         useRadiusInMeter: true,
//                         color: Colors.red.withOpacity(0.3),
//                         borderColor: Colors.red.withOpacity(0.7),
//                         borderStrokeWidth: 2,
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ],
//           )),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/services/ip.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  // Replace with your server URL
  static final String serverUrl = "${ip}/api/liveloction/get?busno=6280";

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _updateDuration =
      Duration(seconds: 1); // Time interval between location updates
  Timer? _timer;
  FlutterMap? _map; // Store the FlutterMap instance

  @override
  void initState() {
    super.initState();
    _fetchData();
    _timer = Timer.periodic(_updateDuration, (_) => _fetchData());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchData() async {
    try {
      var response = await http.get(Uri.parse(MapScreen.serverUrl));
      var data = jsonDecode(response.body);
      double latitude = data['latitude'];
      double longitude = data['longitude'];

      var tileLayer = TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'com.example.Prism',
      );

      var circles = CircleMarker(
        point: LatLng(latitude, longitude), // center of 't Gooi
        radius: 25,
        useRadiusInMeter: true,
        color: Colors.red.withOpacity(0.3),
        borderColor: Colors.red.withOpacity(0.7),
        borderStrokeWidth: 2,
      );

      var map = FlutterMap(
        options: MapOptions(
            initialCenter: LatLng(latitude, longitude), initialZoom: 17),
        children: [
          tileLayer,
          CircleLayer(circles: [circles])
        ],
      );

      setState(() {
        _map = map;
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Live Location Tracking'),
      ),
      body: _map != null ? _map : Center(child: CircularProgressIndicator()),
    );
  }
}
