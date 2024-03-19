import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/services/ip.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class LocationTracker extends StatefulWidget {
  @override
  _LocationTrackerState createState() => _LocationTrackerState();
}

class _LocationTrackerState extends State<LocationTracker> {
  late Position _currentPosition;
  late Timer _timer;
  bool _isSharing = false;

  @override
  void initState() {
    super.initState();
    _currentPosition = Position(
        timestamp: DateTime.now(),
        accuracy: 0.0,
        speedAccuracy: 0.0,
        altitude: 0,
        heading: 0,
        speed: 0,
        latitude: 0,
        longitude: 0); // Initial position
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _checkLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      // Permission granted, start location tracking
      _toggleSharing();
    }
  }

  void _toggleSharing() {
    setState(() {
      _isSharing = !_isSharing;
      if (_isSharing) {
        _startLocationTracking();
      } else {
        _timer.cancel(); // Cancel the timer when stopping sharing
      }
    });
  }

  void _startLocationTracking() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        setState(() {
          _currentPosition = position;
        });
        _sendLocationToServer(position);
      } catch (e) {
        print("Error getting location: $e");
      }
    });
  }

  Future<void> _sendLocationToServer(Position position) async {
    try {
      String apiUrl =
          '${ip}/api/liveloction/?busno=6280'; // Replace with your server's endpoint
      Map<String, dynamic> postData = {
        'latitude': position.latitude,
        'longitude': position.longitude,
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(postData),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        print('Location sent successfully');
      } else {
        print('Failed to send location. Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error sending location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Latitude: ${_currentPosition.latitude}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Longitude: ${_currentPosition.longitude}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_isSharing) {
                  _toggleSharing(); // If sharing, stop sharing
                } else {
                  _checkLocationPermission(); // If not sharing, check permissions and start sharing
                }
              },
              child: Text(_isSharing ? 'Stop Sharing' : 'Start Sharing'),
            ),
          ],
        ),
      ),
    );
  }
}
