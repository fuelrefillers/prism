import 'dart:convert';

import 'package:frontend/hostels/models/BoysFloors.dart';
import 'package:http/http.dart' as http;

class FetchingBoys {
  Future<List<BoysFloors>> fetchBoysFloorsFromApi() async {
    final List<BoysFloors> temp = [];
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:5000/api/boys/floors'));

      final res = json.decode(response.body);
      // print(res);
      // print(res[0]);
      for (int i = 0; i < res.length; i++) {
        BoysFloors post = BoysFloors.fromMap(res[i] as Map<String, dynamic>);
        temp.add(post);
      }
      print("helloo");
      print(temp);
      return temp;
    } catch (err) {
      print(err);
      return [];
    }
  }
}
