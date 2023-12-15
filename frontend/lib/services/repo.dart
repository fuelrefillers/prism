import 'dart:convert';
import 'package:frontend/models/books_model.dart';
import 'package:frontend/models/bus_model.dart';
import 'package:frontend/services/ip.dart';
import 'package:frontend/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PrismRepo {
  static Future<User> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var response = await http.get(
        Uri.parse('${ip}/api/userdata/getuserdata'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      User user = User.fromJson(response.body);
      return user;
    } catch (err) {
      print(err);
      return User(
          StudentName: '--',
          StudentPhnNo: '--',
          StudentEmail: '--',
          FatherName: '--',
          FatherPhnNo: '--',
          FatherEmail: '--',
          MotherName: "--",
          MotherPhnNo: '--',
          MotherEmail: '--',
          RollNo: '--',
          ImageUrl: '--',
          Semester: 0,
          Department: '--',
          Section: '--',
          Actions: '--',
          FeeStatus: false);
    }
  }

  static Future<List<Bus>> getBusses() async {
    List<Bus> busses = [];
    try {
      var response = await http.get(Uri.parse('$ip/api/buses/getbuses'));
      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        Bus post = Bus.fromMap(result[i] as Map<String, dynamic>);
        busses.add(post);
      }
      return busses;
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  static Future<List<Books>> getbooks() async {
    List<Books> books = [];
    try {
      var response =
          await http.get(Uri.parse('$ip/api/books/getbook?category='));
      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        Books post = Books.fromMap(result[i] as Map<String, dynamic>);
        books.add(post);
      }
      return books;
    } catch (err) {
      print(err.toString());
      return [];
    }
  }
}
