import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/providers.dart/attendance_provider.dart';
import 'package:frontend/providers.dart/is_parent_provider.dart';
import 'package:frontend/providers.dart/library_provider.dart';
import 'package:frontend/providers.dart/performance_provider.dart';
import 'package:frontend/providers.dart/token_provider.dart';
import 'package:frontend/providers.dart/user_provider.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/login_screen.dart';
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
      var parentprovider =
          Provider.of<IsParentLoggedIn>(context, listen: false);
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse('http://192.168.29.194:5000/api/user/login'),
        body: jsonEncode({
          'rollno': rollno,
          'password': password,
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
            if (parentprovider.isSignedIn) {
              parentprovider.changeStatus();
            }
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
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

  void loginParent({
    required BuildContext context,
    required String parentphno,
    required String parentpassword,
  }) async {
    try {
      var tokenProvider = Provider.of<TokenProvider>(context, listen: false);
      var parentprovider =
          Provider.of<IsParentLoggedIn>(context, listen: false);
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse('http://192.168.29.194:5000/api/parent/parentlogin'),
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
            if (!parentprovider.isSignedIn) {
              parentprovider.changeStatus();
            }
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
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

  void sendMessages({
    required List<String> rollnumbers,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('http://192.168.29.194:5000/api/sendmessage/'),
        body: jsonEncode({
          'rollnumbers': rollnumbers,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    } catch (err) {
      print(err);
    }
  }

  void getUser(BuildContext context) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      http.Response userRes = await http.get(
        Uri.parse('http://192.168.29.194:5000/api/userdata/getuserdata'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      // print('Bearer $token');
      // print(userRes.body);
      userProvider.setUser(userRes.body);
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  void getAttendance(BuildContext context) async {
    // print("hellloooooooo");
    try {
      var attendanceProvider =
          Provider.of<AttendanceProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      http.Response userRes = await http.get(
        Uri.parse('http://192.168.29.194:5000/api/attendance/getatten'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      // print('Bearer $token');
      // print("attendance");
      // print(userRes.body);
      attendanceProvider.setAttendance(userRes.body);
    } catch (err) {
      // print(err);
    }
  }

  void getPerformance(BuildContext context) async {
    // print("hellloooooooo");
    try {
      var performanceProvider =
          Provider.of<PerformanceProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      http.Response userRes = await http.get(
        Uri.parse('http://192.168.29.194:5000/api/performance/getper'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      // print('Bearer $token');
      // print("attendance");
      // print(userRes.body);
      performanceProvider.setPerformance(userRes.body);
    } catch (err) {
      // print(err);
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
        Uri.parse('http://192.168.29.194:5000/api/library/getlib'),
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

  void signOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('x-auth-token', '');
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
      (route) => false,
    );
  }
}
