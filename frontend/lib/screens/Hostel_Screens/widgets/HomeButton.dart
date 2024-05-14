import 'package:flutter/material.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color themeColor = const Color(0xFF43D19E);

class HomeButton extends StatelessWidget {
  final String title;
  const HomeButton({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('x-auth-token');

        if (token == null || token == '') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(whoissignedin: 'student')));
        }
      },
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: themeColor,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
