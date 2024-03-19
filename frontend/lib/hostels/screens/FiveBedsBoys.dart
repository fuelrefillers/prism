import 'package:flutter/material.dart';
import 'package:frontend/hostels/providers/DetailsProvider.dart';
import 'package:frontend/hostels/screens/BookingDetails.dart';
import 'package:frontend/hostels/services/bookingServiceBoys.dart';
// import 'package:host/providers/DetailsProvider.dart';
//import 'package:host/providers/DetailsProvider.dart';
//import 'package:host/providers/GirlsFloorsProvider.dart';
// import 'package:host/screens/BookingDetails.dart';
//import 'package:provider/provider.dart';
// import 'package:host/services/bookingServiceBoys.dart';
import 'package:provider/provider.dart';
// import 'package:host/screens/DetailsScreen.dart';

class FiveBedsBoys extends StatefulWidget {
  final int roomNumber;
  final int floorNumber;

  const FiveBedsBoys({
    super.key,
    required this.roomNumber,
    required this.floorNumber,
  });

  @override
  State<FiveBedsBoys> createState() => _FiveBedsBoysState();
}

class _FiveBedsBoysState extends State<FiveBedsBoys> {
  int selectedBed = -1; // Track selected bed number
  final BookingServiceBoys booking = BookingServiceBoys();

  @override
  void initState() {
    super.initState();
    print('Room number: ${widget.roomNumber}');
    print('Floor number: ${widget.floorNumber}');
  }

  @override
  Widget build(BuildContext context) {
    // final room = Provider.of<GirlsFloorsProvider>(context);
    //final detailsProvider = Provider.of<DetailsProvider>(context);
    final details = Provider.of<DetailsProvider>(context).details;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bed Selection'), // Generalize title
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        // Use Stack to push content down and overlay button
        children: [
          SingleChildScrollView(
            // Ensure content scrolls vertically
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Room ${widget.roomNumber} Select Your Bed',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildBedButton(1),
                        _buildBedButton(2),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildBedButton(3),
                        _buildBedButton(4),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [_buildBedButton(5)],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            booking.updateBookingsBoys(
                              floorNumber: widget.floorNumber,
                              roomNumber: widget.roomNumber,
                              bedNumber: selectedBed,
                              bookedBy: details?.name ?? 'DefaultName',
                              adminId: details?.adminId ?? 'DefaultName',
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookingDetails(
                                          floorNumber: widget.floorNumber,
                                          roomNumber: widget.roomNumber,
                                          bedNumber: selectedBed,
                                          bookedBy:
                                              details?.name ?? 'DefaultName',
                                          adminId:
                                              details?.adminId ?? 'DefaultName',
                                        )));
                          },
                          child: Text('Confirm Booking'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBedButton(int bedNumber) {
    return TextButton.icon(
      icon: Icon(
        Icons.king_bed,
        size: 42.0,
      ),
      label: Text(
        '$bedNumber',
        style: TextStyle(fontSize: 24.0),
      ),
      onPressed: () => setState(() => selectedBed = bedNumber),
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: selectedBed == bedNumber ? Colors.red : Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        minimumSize: Size(120, 80),
      ),
    );
  }
}
