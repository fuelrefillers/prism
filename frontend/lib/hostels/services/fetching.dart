import 'dart:convert';

import 'package:frontend/hostels/models/GirlsFloors.dart';
import 'package:http/http.dart' as http;

class Fetching {
  Future<List<GirlsFloors>> fetchGirlsFloorsFromApi() async {
    final List<GirlsFloors> temp = [];
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:5000/api/girls/floors'));

      final res = json.decode(response.body);
      //print(res);
      // print(res[0]);
      for (int i = 0; i < res.length; i++) {
        GirlsFloors post = GirlsFloors.fromMap(res[i] as Map<String, dynamic>);
        temp.add(post);
      }
      //print("helloo");
      // print(temp);
      return temp;
    } catch (err) {
      print(err);
      return [];
    }
  }
}


// class Fetching {
//   Future<List<GirlsFloors>> fetchGirlsFloorsFromApi() async {
//     try {
//       final response =
//           await http.get(Uri.parse('http://10.0.2.2:5000/api/girls/floors'));

//       final List<GirlsFloors> temp = [];
//       final res = json.decode(response.body);

//       // Check if the response is a list
//       if (res is List) {
//         for (int i = 0; i < res.length; i++) {
//           GirlsFloors post =
//               GirlsFloors.fromMap(res[i] as Map<String, dynamic>);
//           temp.add(post);
//         }
//         return temp;
//       } else {
//         // Handle the case when the response is not a list
//         print("API response is not a list");
//         return [];
//       }
//     } catch (err) {
//       print(err);
//       return [];
//     }
//   }
// }




