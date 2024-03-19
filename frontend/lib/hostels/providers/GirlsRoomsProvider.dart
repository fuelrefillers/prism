import 'package:flutter/foundation.dart';
import 'dart:convert';
// import 'package:host/models/GirlsRooms.dart';

import 'package:frontend/hostels/models/GirlsRooms.dart';

class GirlsRoomProvider extends ChangeNotifier {
  List<GirlsRooms> _girlsRooms = [];

  List<GirlsRooms> get girlsRooms => _girlsRooms;

  void setGirlsRoomsFromJSON(String rooms) {
    _girlsRooms = List<GirlsRooms>.from(
        jsonDecode(rooms).map((x) => GirlsRooms.fromJson(x)));
    notifyListeners();
  }

  // Updated method to directly set the list of GirlsRooms
  void setGirlsRooms(List<GirlsRooms> rooms) {
    _girlsRooms = rooms;
    notifyListeners();
  }

  // void setGirlsRoomsFromModel(List<GirlsRooms> rooms) {
  //   _girlsRooms = rooms;
  //   notifyListeners();
  // }

  String girlsRoomsToJson() =>
      jsonEncode(_girlsRooms.map((x) => x.toJson()).toList());
}

  





// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:host/models/GirlsRooms.dart';

// class GirlsRoomProvider extends ChangeNotifier {
//   List<GirlsRooms> _girlsRooms = [];

//   List<GirlsRooms> get girlsRooms => _girlsRooms;

//   void setGirlsRoomsFromJSON(String rooms) {
//     _girlsRooms = List<GirlsRooms>.from(
//         jsonDecode(rooms).map((x) => GirlsRooms.fromJson(x)));
//     notifyListeners();
//   }

//   // Updated method to directly set the list of GirlsRooms
//   void setGirlsRooms(List<GirlsRooms> rooms) {
//     _girlsRooms = rooms;
//     notifyListeners();
//   }

//   String girlsRoomsToJson() =>
//       jsonEncode(_girlsRooms.map((x) => x.toJson()).toList());

//   // Define the method to fetch girls' room details from the backend
//   Future<Map<String, dynamic>?> fetchGirlsRoomDetails(String adminId) async {
//     final String apiUrl =
//         'http://10.0.2.2/api/girls/rooms'; // Replace with your actual backend URL

//     try {
//       final response = await http.get(
//         Uri.parse('$apiUrl?adminId=$adminId'),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         // Parse the response and return the details
//         return jsonDecode(response.body);
//       } else {
//         print(
//             'Failed to fetch girls room details. Status code: ${response.statusCode}');
//         return null;
//       }
//     } catch (error) {
//       print('Error fetching girls room details: $error');
//       return null;
//     }
//   }
// }
