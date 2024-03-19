import 'package:flutter/foundation.dart';
import 'dart:convert';
// import 'package:host/models/BoysRooms.dart';

import 'package:frontend/hostels/models/BoysRooms.dart';

class BoysRoomProvider extends ChangeNotifier {
  List<BoysRooms> _boysRooms = [];
  List<BoysRooms> get boysRooms => _boysRooms;

  void setBoysRoomsFromJSON(String rooms) {
    _boysRooms = List<BoysRooms>.from(
        jsonDecode(rooms).map((x) => BoysRooms.fromJson(x)));
    notifyListeners();
  }

  void setBoysRooms(List<BoysRooms> rooms) {
    _boysRooms = rooms;
    notifyListeners();
  }

  String boysRoomsToJson() =>
      jsonEncode(_boysRooms.map((x) => x.toJson()).toList());
}


// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:host/models/BoysRooms.dart';

// class BoysRoomProvider extends ChangeNotifier {
//   List<BoysRooms> _boysRooms = [];
//   List<BoysRooms> get boysRooms => _boysRooms;

//   void setBoysRoomsFromJSON(String rooms) {
//     _boysRooms = List<BoysRooms>.from(
//         jsonDecode(rooms).map((x) => BoysRooms.fromJson(x)));
//     notifyListeners();
//   }

//   void setBoysRooms(List<BoysRooms> rooms) {
//     _boysRooms = rooms;
//     notifyListeners();
//   }

//   String boysRoomsToJson() =>
//       jsonEncode(_boysRooms.map((x) => x.toJson()).toList());

//   // Define the method to fetch boys' room details from the backend
//   Future<Map<String, dynamic>?> fetchBoysRoomDetails(String adminId) async {
//     final String apiUrl =
//         'http://10.0.2.2/api/boys/rooms'; // Replace with your actual backend URL

//     try {
//       final response = await http.get(
//         Uri.parse('$apiUrl?adminId=$adminId'),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         // Parse the response and return the details
//         final boysd = jsonDecode(response.body);
//         print(boysd);
//         return boysd;
//       } else {
//         print(
//             'Failed to fetch boys room details. Status code: ${response.statusCode}');
//         return null;
//       }
//     } catch (error) {
//       print('Error fetching boys room details: $error');
//       return null;
//     }
//   }
// }

