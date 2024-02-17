import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/models/books_model.dart';
import 'package:frontend/models/bus_model.dart';
import 'package:frontend/models/circularModel.dart';
import 'package:frontend/models/semmarks_model.dart';
import 'package:frontend/models/timetable_model.dart';
import 'package:frontend/providers.dart/attendance_provider.dart';
import 'package:frontend/providers.dart/library_provider.dart';
import 'package:frontend/providers.dart/performance_provider.dart';
import 'package:frontend/services/ip.dart';
import 'package:frontend/util/util.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentParentServices {
  // To get library of individual student
  void getLibrary(BuildContext context) async {
    try {
      var libraryProvider =
          Provider.of<LibraryProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      http.Response userRes = await http.get(
        Uri.parse('$ip/api/library/getlib'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      libraryProvider.setLibrary(userRes.body);
    } catch (err) {
      // print(err);
    }
  }
  // getLibrary function ends here

  // to get attendance of individual student
  void getAttendance(BuildContext context) async {
    try {
      var attendanceProvider =
          Provider.of<AttendanceProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      http.Response userRes = await http.get(
        Uri.parse('${ip}/api/attendance/getatten'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      print(jsonDecode(userRes.body));
      attendanceProvider.setAttendance(userRes.body);
    } catch (err) {
      print(err);
    }
  }
  // getAttendance function ends here

  // to get Performance of individual student
  void getPerformance(BuildContext context) async {
    try {
      var performanceProvider =
          Provider.of<PerformanceProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      http.Response userRes = await http.get(
        Uri.parse('${ip}/api/performance/getper'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      performanceProvider.setPerformance(userRes.body);
    } catch (err) {
      //print(err);
    }
  }
  // getPerformance function ends here

  // To get list of all avilable busses
  Future<List<Bus>> getBusses() async {
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
  // getBusses function ends here

// To get all availabe books from server as filtered by department
  Future<List<Books>> getbooks(
      {required BuildContext context,
      required String category,
      required String regulation}) async {
    List<Books> books = [];
    try {
      var response = await http.get(Uri.parse(
          '${ip}/api/books/getbook?department=${category}&regulation=${regulation}'));
      print(response.statusCode);
      httpErrorHandlerWithoutContext(
          response: response,
          context: context,
          onSuccess: () {
            List result = jsonDecode(response.body);

            for (int i = 0; i < result.length; i++) {
              Books post = Books.fromMap(result[i] as Map<String, dynamic>);
              books.add(post);
            }
          });

      print(books);
      return books;
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  // To get sem marks from server
  Future<List<SemMarks>> getmarks(
      BuildContext context, String rollno, String sem) async {
    List<SemMarks> dummy = [];

    try {
      http.Response response = await http.get(
        Uri.parse('${ip}/api/semmarks/find?roolno=${rollno}&sem=sem${sem}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandlerWithoutContext(
          response: response,
          context: context,
          onSuccess: () {
            List result = jsonDecode(response.body);
            //print(response.body);
            for (int i = 0; i < result.length; i++) {
              SemMarks post =
                  SemMarks.fromMap(result[i] as Map<String, dynamic>);
              dummy.add(post);
            }
          });
      return dummy;
    } catch (err) {
      return [];
    }
  }
  // getMarks function ends here

// To get circulars from backend by filtering through department and regulation
  Future<List<CircularsModel>> getCirculars(
      {required String regulation, required String department}) async {
    List<CircularsModel> circulars = [];
    try {
      var response = await http.get(Uri.parse(
          '${ip}/api/circularpdf/getCirculars?regulation=${regulation}&department=${department}'));
      print(response.body);
      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        CircularsModel post =
            CircularsModel.fromMap(result[i] as Map<String, dynamic>);
        circulars.add(post);
      }

      return circulars;
    } catch (err) {
      print(err);
      return [];
    }
  }
  // getCirculars function ends here

// To get list of time tables according to their department and regulation
  Future<List<TimeTable>> getTimetable(
      {required String regulation, required String department}) async {
    List<TimeTable> timetable = [];
    try {
      var response = await http.get(Uri.parse(
          '${ip}/api/timetable/getTimetable?regulation=${regulation}&department=${department}'));
      print(response.body);
      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        TimeTable post = TimeTable.fromMap(result[i] as Map<String, dynamic>);
        timetable.add(post);
      }

      return timetable;
    } catch (err) {
      print(err);
      return [];
    }
  }
  // getTimetable function ends here
}
