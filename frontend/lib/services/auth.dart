import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/faculty-home-screen.dart';
import 'package:frontend/models/books_model.dart';
import 'package:frontend/models/bus_model.dart';
import 'package:frontend/models/faculty_model.dart';
import 'package:frontend/models/semmarks_model.dart';
import 'package:frontend/providers.dart/attendance_provider.dart';
import 'package:frontend/providers.dart/faculty_login_provider.dart';
import 'package:frontend/providers.dart/faculty_provider.dart';
//import 'package:frontend/providers.dart/who_is_signed_in.dart';
import 'package:frontend/providers.dart/library_provider.dart';
import 'package:frontend/providers.dart/performance_provider.dart';
import 'package:frontend/providers.dart/token_provider.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/services/ip.dart';
import 'package:frontend/util/util.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authservice {
  void loginUser({
    required BuildContext context,
    required String rollno,
    required String password,
  }) async {
    try {
      var tokenProvider = Provider.of<TokenProvider>(context, listen: false);
      var facultyProvider =
          Provider.of<IsfacultyLoggedIn>(context, listen: false);
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse('${ip}/api/userdata/login'),
        body: jsonEncode({
          'UserName': rollno.toUpperCase(),
          'Password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            //userProvider.setUser(res.body);
            tokenProvider.setToken(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            await prefs.setString('isParentloggedin', "true");

            if (facultyProvider.isSignedIn) {
              facultyProvider.changeStatus();
            }

            await prefs.setString('whoIsSignedIn', "student");
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => HomeScreen(whoissignedin: "student"),
              ),
              (route) => false,
            );
          },
        );
      }
      print(res);
    } catch (err) {
      showSnackBar(context, err.toString());
      print(err);
    }
  }

  void loginfaculty({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    try {
      var tokenProvider = Provider.of<TokenProvider>(context, listen: false);
      var facultyProvider =
          Provider.of<IsfacultyLoggedIn>(context, listen: false);
      final navigator = Navigator.of(context);
      // navigator.pushAndRemoveUntil(
      //   MaterialPageRoute(
      //     builder: (context) => FacultyHomeScreen(),
      //   ),
      //   (route) => false,
      // );

      http.Response res = await http.post(
        Uri.parse('http://192.168.29.194:3000/api/faculty/login'),
        body: jsonEncode({
          'UserName': username,
          'Password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            //userProvider.setUser(res.body);
            tokenProvider.setToken(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            await prefs.setString('whoIsSignedIn', "faculty");
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => FacultyHomeScreen(),
              ),
              (route) => false,
            );
          },
        );
      }
      print(res);
    } catch (err) {
      showSnackBar(context, err.toString());
      print(err);
    }
  }

  // void loginfaculty({required BuildContext context}) {
  //   final navigator = Navigator.of(context);
  //   var facultyProvider =
  //       Provider.of<IsfacultyLoggedIn>(context, listen: false);
  //   facultyProvider.changeStatus();
  //   navigator.pushAndRemoveUntil(
  //     MaterialPageRoute(
  //       builder: (context) => FacultyHomeScreen(),
  //     ),
  //     (route) => false,
  //   );
  // }

  void loginParent({
    required BuildContext context,
    required String parentphno,
    required String parentpassword,
  }) async {
    try {
      var tokenProvider = Provider.of<TokenProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse('$ip/api/parent/parentlogin'),
        body: jsonEncode({
          'parentphno': parentphno,
          'parentpassword': parentpassword,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            //userProvider.setUser(res.body);
            tokenProvider.setToken(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            await prefs.setString('whoIsSignedIn', "parent");
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(whoissignedin: "parent"),
              ),
              (route) => false,
            );
          },
        );
      }
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  void setAttendance({
    required List<String> rollnumbers,
    required String section,
    required String department,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse(
            'http://15.20.17.222:3000/api/attendance/setAttendance?section=${section}&department=${department}'),
        body: jsonEncode({
          'rollNumbers': rollnumbers,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res);
    } catch (err) {
      print(err);
    }
  }

  // void getUser(BuildContext context) async {
  //   try {
  //     var userProvider = Provider.of<UserProvider>(context, listen: false);
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? token = prefs.getString('x-auth-token');

  //     if (token == null) {
  //       prefs.setString('x-auth-token', '');
  //     }

  //     http.Response userRes = await http.get(
  //       Uri.parse('$ip/api/userdata/getuserdata'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer $token'
  //       },
  //     );
  //     // print('Bearer $token');
  //     // print(userRes.body);
  //     userProvider.setUser(userRes.body);
  //   } catch (err) {
  //     showSnackBar(context, err.toString());
  //   }
  // }

  // static Future<List<Bus>> getBusses(BuildContext context) async {
  //   List<Bus> busses = [];
  //   try {
  //     var response = await http.get(Uri.parse('$ip/api/buses/getbuses'));

  //     httpErrorHandlerWithoutContext(
  //         response: response,
  //         context: context,
  //         onSuccess: () {
  //           List result = jsonDecode(response.body);

  //           for (int i = 0; i < result.length; i++) {
  //             Bus post = Bus.fromMap(result[i] as Map<String, dynamic>);
  //             busses.add(post);
  //           }
  //         });

  //     return busses;
  //   } catch (err) {
  //     print(err.toString());
  //     return [];
  //   }
  // }

  Future<List<Books>> getbooks(BuildContext context, String category) async {
    List<Books> books = [];
    try {
      var response = await http
          .get(Uri.parse('$ip/api/books/getbook?category=${category}'));

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
      return books;
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  Future<List<SemMarks>> getmarks(
      BuildContext context, String rollno, String sem) async {
    List<SemMarks> dummy = [];

    try {
      //print("hello");
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
      //print(dummy[0].Credits);
    } catch (err) {
      print(err);
      showSnackBar(context, err.toString());
      return [];
    }
  }

  void getAttendance(BuildContext context) async {
    print("hellloooooooo");
    try {
      var attendanceProvider =
          Provider.of<AttendanceProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      http.Response userRes = await http.get(
        Uri.parse('http://15.20.17.222:3000/api/attendance/getatten'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      // print('Bearer $token');
      // print("attendance");
      print(userRes.body);
      attendanceProvider.setAttendance(userRes.body);
    } catch (err) {
      print(err);
    }
  }

  void getPerformance(BuildContext context) async {
    print("hellloooooooo");
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
      // print('Bearer $token');
      // print("attendance");
      print(userRes.body);
      performanceProvider.setPerformance(userRes.body);
    } catch (err) {
      print(err);
    }
  }

  void getLibrary(BuildContext context) async {
    print("hellloooooooo");
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
      print('Bearer $token');
      print("attendance");
      print(userRes.body);
      libraryProvider.setLibrary(userRes.body);
    } catch (err) {
      // print(err);
    }
  }

  void getFaculty(BuildContext context) async {
    try {
      final facultyprovider =
          Provider.of<FacultyProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var response = await http.get(
        Uri.parse('http://15.20.17.222:3000/api/faculty/getFacultydata'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      print(response.body);
      facultyprovider.setFaculty(response.body);
    } catch (err) {
      print(err);
    }
  }

  void signOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('x-auth-token', '');
    await prefs.setString('whoIsSignedIn', "");
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
      (route) => false,
    );
  }
}
