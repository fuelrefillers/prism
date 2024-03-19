import 'package:flutter/material.dart';
import 'package:frontend/hostels/screens/BookingDetails.dart';
import 'package:frontend/hostels/services/bookingService.dart';
import 'package:provider/provider.dart';
import '../providers/DetailsProvider.dart';

class SixBeds extends StatefulWidget {
  final int roomNumber;
  final int floorNumber;

  const SixBeds({
    super.key,
    required this.roomNumber,
    required this.floorNumber,
  });

  @override
  State<SixBeds> createState() => _SixBedsState();
}

class _SixBedsState extends State<SixBeds> {
  int selectedBed = -1; // Track selected bed number
  final BookingService booking = BookingService();

  @override
  void initState() {
    super.initState();
    print('Room number: ${widget.roomNumber}');
    print('Floor number: ${widget.floorNumber}');
  }

  @override
  Widget build(BuildContext context) {
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
                      children: [_buildBedButton(5), _buildBedButton(6)],
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
                            booking.updateBookings(
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
