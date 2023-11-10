import 'package:flutter/material.dart';
//import 'package:frontend/screens/profile_screen.dart';

class Buttonhome extends StatelessWidget {
  const Buttonhome(
      {super.key,
      required this.category,
      required this.icon,
      required this.screen});
  final String category;
  final IconData icon;
  final Widget screen;
  // final String categoryIcon;
  // , required this.categoryIcon
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: Size.zero, // Set this
          padding: EdgeInsets.zero, // and this
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => screen,
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(icon), Text(category)],
      ),
    );
  }
}
