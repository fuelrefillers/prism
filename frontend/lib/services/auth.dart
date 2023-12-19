import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/Faculty_Module/faculty-home-screen.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/services/ip.dart';
import 'package:frontend/util/util.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Authservice {
  void loginUser({
    required BuildContext context,
    required String rollno,
    required String password,
  }) async {
    try {
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
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
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
    } catch (err) {
      showSnackBar(context, "something went wrong");
    }
  }

  void loginfaculty({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    try {
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse('${ip}/api/faculty/login'),
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
