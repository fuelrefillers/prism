import 'package:flutter/material.dart';

Color themeColor = const Color(0xFF43D19E);

class HomeButton extends StatelessWidget {
  final String title;
  final Widget onTap;
  const HomeButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => onTap));
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
