import 'package:flutter/material.dart';
// import 'package:host/providers/BoysRoomsPriovider.dart';
// import 'package:host/providers/GirlsRoomsProvider.dart';
// import 'package:provider/provider.dart';

class BookingDetails extends StatelessWidget {
  final int floorNumber;
  final int roomNumber;
  final int bedNumber;
  final String bookedBy;
  final String adminId;

  const BookingDetails({
    Key? key,
    required this.floorNumber,
    required this.roomNumber,
    required this.bedNumber,
    required this.adminId,
    required this.bookedBy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool roomIsBooked = floorNumber != null &&
    //     roomNumber != null &&
    //     bedNumber != null &&
    //     adminId.isNotEmpty &&
    //     bookedBy.isNotEmpty;
    // final boys = Provider.of<BoysRoomProvider>(context);
    // final girls = Provider.of<GirlsRoomProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: MediaQuery.of(context).size.height / 2.5,
          width: double.infinity,
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Hello ${bookedBy} your booking details are followed by ',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Text(
                      'AdminId: ${adminId} ',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Text(
                      'Floor Number: ${floorNumber}',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      'Room Number: ${roomNumber}',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      'Bed Number: ${bedNumber}',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:host/providers/BoysRoomsPriovider.dart';
// import 'package:host/providers/GirlsRoomsProvider.dart';
// import 'package:provider/provider.dart';

// class BookingDetails extends StatelessWidget {
//   final int floorNumber;
//   final int roomNumber;
//   final int bedNumber;
//   final String bookedBy;
//   final String adminId;

//   const BookingDetails({
//     Key? key,
//     required this.floorNumber,
//     required this.roomNumber,
//     required this.bedNumber,
//     required this.adminId,
//     required this.bookedBy,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final boys = Provider.of<BoysRoomProvider>(context);
//     final girls = Provider.of<GirlsRoomProvider>(context);

//     bool isRoomBooked =boys.status[index] == "booked" || girls.status[index] == "booked";

//     if (isRoomBooked) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Booking Details'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Container(
//             height: MediaQuery.of(context).size.height / 2.5,
//             width: double.infinity,
//             child: Card(
//               elevation: 4.0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12.0),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: Text(
//                         'Hello $bookedBy, your booking details are as follows',
//                         style: TextStyle(fontSize: 24.0),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20.0,
//                     ),
//                     Center(
//                       child: Text(
//                         'AdminId: $adminId',
//                         style: TextStyle(fontSize: 20.0),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10.0,
//                     ),
//                     Center(
//                       child: Text(
//                         'Floor Number: $floorNumber',
//                         style: TextStyle(fontSize: 20.0),
//                       ),
//                     ),
//                     const SizedBox(height: 10.0),
//                     Center(
//                       child: Text(
//                         'Room Number: $roomNumber',
//                         style: TextStyle(fontSize: 20.0),
//                       ),
//                     ),
//                     const SizedBox(height: 10.0),
//                     Center(
//                       child: Text(
//                         'Bed Number: $bedNumber',
//                         style: TextStyle(fontSize: 20.0),
//                       ),
//                     ),
//                     const SizedBox(height: 10.0),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     } else {
//       // Navigate to ContainerScreen
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => ContainerScreen()),
//       );

//       // Return an empty container (or you can return a loading indicator, etc.)
//       return Container();
//     }
//   }
// }

// class ContainerScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Container Screen'),
//       ),
//       body: Center(
//         child: Text('Container Screen Content'),
//       ),
//     );
//   }
// }


