import 'package:flutter/material.dart';
import 'package:frontend/hostels/providers/DetailsProvider.dart';
import 'package:frontend/hostels/screens/BookingDetails.dart';
import 'package:frontend/hostels/services/bookingService.dart';
import 'package:provider/provider.dart';

class FiveBeds extends StatefulWidget {
  final int roomNumber;
  final int floorNumber;

  const FiveBeds({
    super.key,
    required this.roomNumber,
    required this.floorNumber,
  });

  @override
  State<FiveBeds> createState() => _FiveBedsState();
}

class _FiveBedsState extends State<FiveBeds> {
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


// import 'package:flutter/material.dart';
// import 'package:host/models/GirlsRooms.dart';
// import 'package:host/providers/GirlsRoomsProvider.dart';
// import 'package:host/screens/BookingDetails.dart';
// import 'package:host/services/BookingService.dart';
// import 'package:provider/provider.dart';

// class FiveBeds extends StatefulWidget {
//   final int roomNumber;
//   final int floorNumber;

//   const FiveBeds({
//     Key? key,
//     required this.roomNumber,
//     required this.floorNumber,
//   }) : super(key: key);

//   @override
//   State<FiveBeds> createState() => _FiveBedsState();
// }

// class _FiveBedsState extends State<FiveBeds> {
//   int selectedBed = -1; // Track selected bed number

//   @override
//   void initState() {
//     super.initState();
//     print('Room number: ${widget.roomNumber}');
//     print('Floor number: ${widget.floorNumber}');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final roomProvider = Provider.of<GirlsRoomProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bed Selection'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Container(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Room ${widget.roomNumber} Select Your Bed',
//                         style: TextStyle(
//                             fontSize: 22.0, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20.0),
//                   IntrinsicHeight(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         _buildBedButton(1),
//                         _buildBedButton(2),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20.0),
//                   IntrinsicHeight(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         _buildBedButton(3),
//                         _buildBedButton(4),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20.0),
//                   IntrinsicHeight(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [_buildBedButton(5)],
//                     ),
//                   ),
//                   const SizedBox(height: 20.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () async {
//                           if (selectedBed != -1) {
//                             // Use BookingService to update bookings
//                             print('Attempting to book room...');
//                             bool bookingResult =
//                                 await BookingService().updateBookings(
//                               floorNumber: widget.floorNumber,
//                               roomNumber: widget.roomNumber,
//                               bedNumber: selectedBed,
//                               bookedBy: [
//                                 'John Doe'
//                               ], // Replace with actual user information
//                               status: [
//                                 Status.AVAILABLE
//                               ], // Replace with actual status
//                               adminId: [
//                                 Status.AVAILABLE
//                               ], // Replace with actual admin ID
//                             );

//                             if (bookingResult) {
//                               // If booking is successful, navigate to BookingDetails
//                               print('Room booked successfully!');
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => BookingDetails(
//                                     floorNumber: widget.floorNumber,
//                                     roomNumber: widget.roomNumber,
//                                     bedNumber: selectedBed,
//                                   ),
//                                 ),
//                               );

//                               // Update GirlsRoomProvider with booked room information
//                               roomProvider.setGirlsRooms(
//                                 floorNumber: widget.floorNumber,
//                                 roomNumber: widget.roomNumber,
//                                 bedNumber: selectedBed,
//                                 bookedBy: [
//                                   'John Doe'
//                                 ], // Replace with actual user information
//                                 status: [
//                                   Status.AVAILABLE
//                                 ], // Replace with actual status
//                                 adminId: [
//                                   Status.AVAILABLE
//                                 ], // Replace with actual admin ID
//                               );
//                             } else {
//                               // Handle booking failure
//                               print('Failed to book the room.');
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text('Failed to book the room.'),
//                                 ),
//                               );
//                             }
//                           } else {
//                             // No bed selected, show a message
//                             print('Please select a bed first.');
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('Please select a bed first.'),
//                               ),
//                             );
//                           }
//                         },
//                         child: Text('Confirm Booking'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBedButton(int bedNumber) {
//     return TextButton.icon(
//       icon: Icon(
//         Icons.king_bed,
//         size: 42.0,
//       ),
//       label: Text(
//         '$bedNumber',
//         style: TextStyle(fontSize: 24.0),
//       ),
//       onPressed: () => setState(() => selectedBed = bedNumber),
//       style: TextButton.styleFrom(
//         foregroundColor: Colors.white,
//         backgroundColor: selectedBed == bedNumber ? Colors.red : Colors.green,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         minimumSize: Size(120, 80),
//       ),
//     );
//   }
// }
