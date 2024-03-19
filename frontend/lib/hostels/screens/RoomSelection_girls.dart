import 'package:flutter/material.dart';
import 'package:frontend/hostels/screens/FiveBeds.dart';
import 'package:frontend/hostels/screens/SixBeds.dart';

class RoomSelection_girls extends StatelessWidget {
  final int floor;

  RoomSelection_girls({required this.floor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Selection'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemCount: 21,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  int roomNumber = (floor * 100) + index + 1;

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _onRoomButtonPressed(context, roomNumber, floor);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        minimumSize:
                            Size(100, 100), // Adjust button size as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.door_sliding,
                              color: Colors.black, size: 32.0),
                          SizedBox(height: 4.0),
                          Text(
                            roomNumber.toString(),
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onRoomButtonPressed(
      BuildContext context, int roomNumber, int floorNumber) {
    if ([21, 121, 221, 321, 421].contains(roomNumber)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SixBeds(
            roomNumber: roomNumber,
            floorNumber: floorNumber,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FiveBeds(
            roomNumber: roomNumber,
            floorNumber: floorNumber,
          ),
        ),
      );
    }
  }
}
// import 'package:flutter/material.dart';
// //import 'package:hostel/BedSelectionScreen.dart';
// import 'package:hostel/BedSelectionGirls.dart';

// class RoomSelection_girls extends StatelessWidget {
//   final int floor;

//   RoomSelection_girls({required this.floor});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Room Selection'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(8.0),
//         child: ListView(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16.0),
//               ),
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   mainAxisSpacing: 8.0,
//                   crossAxisSpacing: 8.0,
//                 ),
//                 itemCount: 21,
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   int roomNumber = (floor * 100) + index + 1;

//                   return Container(
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(8.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     margin: EdgeInsets.all(8.0),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         _onRoomButtonPressed(context, roomNumber);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         primary: Color.fromARGB(255, 224, 241, 98),
//                         elevation: 0,
//                         minimumSize:
//                             Size(100, 100), // Adjust button size as needed
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.door_sliding,
//                               color: Colors.black, size: 32.0),
//                           SizedBox(height: 4.0),
//                           Text(
//                             roomNumber.toString(),
//                             style:
//                                 TextStyle(fontSize: 18.0, color: Colors.black),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _onRoomButtonPressed(BuildContext context, int roomNumber) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BedSelectionGirls(roomNumber: roomNumber),
//       ),
//     );
//   }
// }
