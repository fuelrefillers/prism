// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:frontend/hostels/models/DetailsModel.dart';
// import 'package:frontend/hostels/providers/DetailsProvider.dart';
// import 'package:frontend/hostels/screens/ContainerScreen.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

// class DetailsScreen extends StatefulWidget {
//   const DetailsScreen({Key? key}) : super(key: key);

//   @override
//   State<DetailsScreen> createState() => _DetailsScreenState();
// }

// class _DetailsScreenState extends State<DetailsScreen> {
//   TextEditingController adminIdController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   String selectedGender = ''; // Added variable to store selected gender

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Details Screen'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 margin: EdgeInsets.only(bottom: 16.0),
//                 child: TextField(
//                   controller: adminIdController,
//                   decoration: InputDecoration(
//                     labelText: 'Enter your AdminID',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(bottom: 16.0),
//                 child: TextField(
//                   controller: nameController,
//                   decoration: InputDecoration(
//                     labelText: 'Enter your Name',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ),
//               // Added Row with Radio buttons for gender selection
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Radio(
//                     value: 'boys',
//                     groupValue: selectedGender,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedGender = value.toString();
//                       });
//                     },
//                   ),
//                   Text('Boys'),
//                   SizedBox(width: 16.0),
//                   Radio(
//                     value: 'girls',
//                     groupValue: selectedGender,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedGender = value.toString();
//                       });
//                     },
//                   ),
//                   Text('Girls'),
//                 ],
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   // Create Details object
//                   Details details = Details(
//                     adminId: adminIdController.text,
//                     name: nameController.text,
//                   );

//                   // Make a POST request to update the details in the backend
//                   await updateDetailsOnServer(details);

//                   // Set details using the provider
//                   Provider.of<DetailsProvider>(context, listen: false)
//                       .setDetails(details);

//                   // Navigate to the container screen
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => ContainerScreen()),
//                   );
//                 },
//                 child: const Text('Proceed'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Future<void> updateDetailsOnServer(Details details) async {
//   final String apiUrl = 'http://10.0.2.2:5000/api/verify'; // for emulator

//   try {
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(<String, String>{
//         'adminId': details.adminId,
//         'userName': details.name,
//       }),
//     );

//     if (response.statusCode == 200) {
//       print('Details updated successfully on the server.');
//     } else {
//       print(
//           'Failed to update details on the server. Status code: ${response.statusCode}');
//       throw Exception('Failed to update details on the server.');
//     }
//   } catch (error) {
//     print('Error: $error');
//     throw Exception('Failed to update details on the server.');
//   }
// }









// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:host/models/DetailsModel.dart';
// import 'package:host/providers/DetailsProvider.dart';
// import 'package:host/providers/verifyProvider.dart';
// import 'package:host/screens/BookingDetails.dart';
// import 'package:host/screens/ContainerScreen.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

// class DetailsScreen extends StatefulWidget {
//   const DetailsScreen({Key? key}) : super(key: key);

//   @override
//   State<DetailsScreen> createState() => _DetailsScreenState();
// }

// class _DetailsScreenState extends State<DetailsScreen> {
//   TextEditingController adminIdController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   String selectedGender = ''; // Added variable to store selected gender

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Details Screen'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 margin: EdgeInsets.only(bottom: 16.0),
//                 child: TextField(
//                   controller: adminIdController,
//                   decoration: InputDecoration(
//                     labelText: 'Enter your AdminID',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(bottom: 16.0),
//                 child: TextField(
//                   controller: nameController,
//                   decoration: InputDecoration(
//                     labelText: 'Enter your Name',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ),
//               // Added Row with Radio buttons for gender selection
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Radio(
//                     value: 'boys',
//                     groupValue: selectedGender,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedGender = value.toString();
//                       });
//                     },
//                   ),
//                   Text('Boys'),
//                   SizedBox(width: 16.0),
//                   Radio(
//                     value: 'girls',
//                     groupValue: selectedGender,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedGender = value.toString();
//                       });
//                     },
//                   ),
//                   Text('Girls'),
//                 ],
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   // Create Details object
//                   Details details = Details(
//                     adminId: adminIdController.text,
//                     name: nameController.text,
//                   );

//                   // Make a POST request to update the details in the backend
//                   await updateDetailsOnServer(details);

//                   // Set details using the provider
//                   Provider.of<DetailsProvider>(context, listen: false)
//                       .setDetails(details);
//                   //initiaing verify provider to check the admin id in database
//                   final verify =
//                       Provider.of<VerifyProvider>(context, listen: false)
//                           .verify
//                           ?.adminId;
//                   if (verify != null && adminIdController.text == verify) {
//                     final fetchedRoomDetails =
//                         await fetchRoomDetails(details.adminId, selectedGender);

//                     if (fetchedRoomDetails != null) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BookingDetails(
//                             floorNumber: fetchedRoomDetails['floorNumber'],
//                             roomNumber: fetchedRoomDetails['roomNumber'],
//                             bedNumber: fetchedRoomDetails['bedNumber'],
//                             adminId: details.adminId,
//                             bookedBy: details.name,
//                           ),
//                         ),
//                       );
//                     }
//                   }
//                   else {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => ContainerScreen()));
//                   }
//                 },
//                 child: const Text('Proceed'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// Future<void> updateDetailsOnServer(Details details) async {
//   final String apiUrl = 'http://10.0.2.2:5000/api/verify'; // for emulator

//   try {
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(<String, String>{
//         'adminId': details.adminId,
//         'userName': details.name,
//       }),
//     );

//     if (response.statusCode == 200) {
//       print('Details updated successfully on the server.');
//     } else {
//       print(
//           'Failed to update details on the server. Status code: ${response.statusCode}');
//       throw Exception('Failed to update details on the server.');
//     }
//   } catch (error) {
//     print('Error: $error');
//     throw Exception('Failed to update details on the server.');
//   }
// }

// Future<Map<String, dynamic>?> fetchRoomDetails(
//     String adminId, String gender) async {
//   final String apiUrl = gender.toLowerCase() == 'girls'
//       ? 'http://10.0.2.2/api/girls/rooms'
//       : 'http://10.0.2.2/api/boys/rooms';

//   try {
//     final response = await http.get(
//       Uri.parse('$apiUrl?adminId=$adminId'),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       print(
//           'Failed to fetch room details. Status code: ${response.statusCode}');
//       return null;
//     }
//   } catch (error) {
//     print('Error fetching room details: $error');
//     return null;
//   }
// }






