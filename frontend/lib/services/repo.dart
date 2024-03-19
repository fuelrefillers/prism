import 'dart:convert';
import 'package:frontend/chatting/socketio.dart';
import 'package:frontend/models/books_model.dart';
import 'package:frontend/models/faculty_model.dart';
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
          Regulation: "--s",
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

  // static Future<TimeTableForStudents> getStudentTimeTable() async {
  //   try {

  //   } catch (e) {
  //     print(e);
  //   }
  // }

  static Future<Faculty> getFaculty() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var response = await http.get(
        Uri.parse('${ip}/api/faculty/getFacultydata'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      // print(response.body);
      // facultyprovider.setFaculty(response.body);

      Faculty faculty = Faculty.fromJson(response.body);
      var result = jsonDecode(response.body);
      SocketService().emitSignInEvent(result['FacultyId']);

      return faculty;
    } catch (err) {
      print("Hello from repo ${err}");
      return Faculty(
          FacultyId: "--",
          FacultyName: "--",
          FacultyDesignation: "--",
          FacultyPhnNo: "--",
          FacultyDepartment: "--",
          Classes: [],
          IsAdmin: false,
          AcceptedSubstitueInfo: [],
          InQueueSubstituteInfo: []);
    }
  }

  static Future<List<Books>> getbooks() async {
    List<Books> books = [];
    try {
      var response =
          await http.get(Uri.parse('${ip}/api/books/getbook?category='));
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
