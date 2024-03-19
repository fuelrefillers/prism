import 'dart:convert';
//import 'package:host/models/GirlsRooms.dart';
import 'package:http/http.dart' as http;

class BookingService {
  // Store API endpoint URL and any other sensitive data securely
  final String _apiUrl = 'http://10.0.2.2:5000';

  Future<bool> updateBookings({
    required int floorNumber,
    required int roomNumber,
    required int bedNumber,
    required String bookedBy,
    required String adminId,
  }) async {
    try {
      // Make the POST request with the constructed request body
      final response = await http.post(
        Uri.parse(_apiUrl + '/api/girls/bookroom'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "floorNumber": floorNumber,
          "roomNumber": roomNumber,
          "bedNumber": bedNumber,
          "username": bookedBy,
          "adminId": adminId,
        }),
      );

      // Handle the response based on the status code
      if (response.statusCode == 200) {
        // Room booked successfully
        // Update local booking state or perform other actions (add to _bookings?)
        print('Room booked successfully!');
        return true;
      } else {
        // Room booking failed
        print("Failed to book room. Status code: ${response.statusCode}");
        // Log or handle the specific error (e.g., handle network errors differently)
        return false;
      }
    } catch (e) {
      // Catch and handle specific exceptions for more detailed error handling
      print("Error during API call: $e");
      return false;
    }
  }
}





// import 'dart:convert';
// import 'package:host/models/GirlsRooms.dart';
// import 'package:http/http.dart' as http;

// class BookingService {
//   // Create an empty list to store booked rooms
//   final List<Map<String, dynamic>> bookings = [];

//   Future<bool> updateBookings({
//     required int floorNumber,
//     required int roomNumber,
//     required int bedNumber,
//     required List<dynamic> bookedBy,
//     required List<Status> status,
//     required List<Status> adminId,
//   }) async {
//     try {
//       // Make a POST request to the API endpoint with the provided details
//       final response = await http.post(
//         Uri.parse('http://10.0.2.2:5000/api/girls/bookroom'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           "floorNumber": floorNumber,
//           "roomNumber": roomNumber,
//           "bedNumber": bedNumber,
//           "bookedBy": bookedBy,
//           "status": status.map((s) => statusValues.reverse[s]).toList(),
//           "adminId": adminId.map((a) => statusValues.reverse[a] ?? "").toList(),
//           // Add other necessary fields here
//         }),
//       );

//       // Handle response and update local booking state
//       if (response.statusCode == 200) {
//         // Room booked successfully
//         bookings.add({
//           "floorNumber": floorNumber,
//           "roomNumber": roomNumber,
//           "bedNumber": bedNumber,
//           "bookedBy": bookedBy,
//           "status": status,
//           "adminId": adminId,
//           // Add other necessary fields here
//         });
//         print('Room booked successfully!');
//         return true;
//       } else {
//         // Room booking failed
//         print("Failed to book room. Status code: ${response.statusCode}");
//         return false;
//       }
//     } catch (err) {
//       // Handle error during the API call
//       print("Error during API call: $err");
//       return false;
//     }
//   }
// }
